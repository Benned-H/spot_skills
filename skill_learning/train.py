"""Training script for BC-RNN on Spot manipulation demonstrations."""

from __future__ import annotations

import argparse
import os

import torch
import torch.nn as nn
import yaml

try:
    import wandb
except ImportError:
    wandb = None
from torch.utils.data import DataLoader, random_split

from src.dataset import BCRNNDataset
from src.model import BCRNNModel


def train(config: dict) -> None:
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f"Device: {device}")

    wandb_cfg = config.get("wandb", {})
    use_wandb = wandb_cfg.get("enabled", False) and wandb is not None
    if use_wandb:
        wandb.init(
            project=wandb_cfg.get("project", "bc-rnn-spot"),
            name=wandb_cfg.get("run_name"),
            config=config,
        )

    model_cfg = config["model"]

    # Dataset
    dataset = BCRNNDataset(
        data_paths=config["data"],
        joint_name=config["joint_name"],
        image_size=(model_cfg["image_size"], model_cfg["image_size"]),
        seq_len=config["seq_len"],
        delta_actions=config.get("delta_actions", True),
    )
    print(f"Dataset: {len(dataset)} samples")

    # Train / val split
    val_size = max(1, int(len(dataset) * config["val_ratio"]))
    train_size = len(dataset) - val_size
    train_ds, val_ds = random_split(dataset, [train_size, val_size])
    print(f"Train: {train_size}, Val: {val_size}")

    train_loader = DataLoader(train_ds, batch_size=config["batch_size"], shuffle=True, num_workers=config["num_workers"])
    val_loader = DataLoader(val_ds, batch_size=config["batch_size"], shuffle=False, num_workers=config["num_workers"])

    # Model
    model = BCRNNModel(
        state_dim=model_cfg["state_dim"],
        action_dim=model_cfg["action_dim"],
        hidden_dim=model_cfg["hidden_dim"],
        in_channels=model_cfg["in_channels"],
        freeze_backbone=model_cfg["freeze_backbone"],
    ).to(device)
    print(f"Parameters: {sum(p.numel() for p in model.parameters() if p.requires_grad):,} trainable")

    optimizer = torch.optim.Adam(model.parameters(), lr=config["lr"], weight_decay=config["weight_decay"])
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=config["epochs"])
    criterion = nn.MSELoss()

    # Training loop
    best_val_loss = float("inf")
    os.makedirs(config["save_dir"], exist_ok=True)

    for epoch in range(1, config["epochs"] + 1):
        # --- Train ---
        model.train()
        train_loss = 0.0
        for images, states, actions in train_loader:
            images = images.to(device)
            states = states.to(device)
            actions = actions.to(device)

            pred_actions, _ = model(images, states)
            loss = criterion(pred_actions, actions)

            optimizer.zero_grad()
            loss.backward()
            if config["grad_clip"] > 0:
                nn.utils.clip_grad_norm_(model.parameters(), config["grad_clip"])
            optimizer.step()

            train_loss += loss.item() * images.size(0)

        train_loss /= train_size
        scheduler.step()

        # --- Validate ---
        model.eval()
        val_loss = 0.0
        with torch.no_grad():
            for images, states, actions in val_loader:
                images = images.to(device)
                states = states.to(device)
                actions = actions.to(device)

                pred_actions, _ = model(images, states)
                loss = criterion(pred_actions, actions)
                val_loss += loss.item() * images.size(0)

        val_loss /= val_size

        lr = optimizer.param_groups[0]["lr"]
        print(f"Epoch {epoch:03d}/{config['epochs']}  train_loss={train_loss:.6f}  val_loss={val_loss:.6f}  lr={lr:.2e}")

        if use_wandb:
            wandb.log({"train_loss": train_loss, "val_loss": val_loss, "lr": lr}, step=epoch)

        # Save best
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            path = os.path.join(config["save_dir"], "best.pt")
            torch.save({"epoch": epoch, "model": model.state_dict(), "val_loss": val_loss}, path)
            print(f"  -> saved best model (val_loss={val_loss:.6f})")

        # Periodic checkpoint
        if epoch % config["save_every"] == 0:
            path = os.path.join(config["save_dir"], f"epoch_{epoch:03d}.pt")
            torch.save({"epoch": epoch, "model": model.state_dict(), "val_loss": val_loss}, path)

    # Save final
    path = os.path.join(config["save_dir"], "final.pt")
    torch.save({"epoch": config["epochs"], "model": model.state_dict(), "val_loss": val_loss}, path)
    print(f"Training complete. Best val_loss={best_val_loss:.6f}")

    if use_wandb:
        wandb.finish()


def main() -> None:
    parser = argparse.ArgumentParser(description="Train BC-RNN for Spot manipulation")
    parser.add_argument(
        "--config",
        type=str,
        default="config/training_params.yaml",
        help="Path to YAML config file",
    )
    args = parser.parse_args()

    with open(args.config, "r") as f:
        config = yaml.safe_load(f)

    train(config)


if __name__ == "__main__":
    main()
