"""Training script for BC-RNN on Spot manipulation demonstrations."""

from __future__ import annotations

import argparse
import os
import time

import torch
import torch.nn as nn
from torch.utils.data import DataLoader, random_split

from src.dataset import BCRNNDataset
from src.model import BCRNNModel


def train(args: argparse.Namespace) -> None:
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f"Device: {device}")

    # Dataset
    dataset = BCRNNDataset(
        data_paths=args.data,
        joint_name=args.joint_name,
        image_size=(args.image_size, args.image_size),
        seq_len=args.seq_len,
    )
    print(f"Dataset: {len(dataset)} samples")

    # Train / val split
    val_size = max(1, int(len(dataset) * args.val_ratio))
    train_size = len(dataset) - val_size
    train_ds, val_ds = random_split(dataset, [train_size, val_size])
    print(f"Train: {train_size}, Val: {val_size}")

    train_loader = DataLoader(train_ds, batch_size=args.batch_size, shuffle=True, num_workers=args.num_workers)
    val_loader = DataLoader(val_ds, batch_size=args.batch_size, shuffle=False, num_workers=args.num_workers)

    # Model
    model = BCRNNModel(
        state_dim=args.state_dim,
        action_dim=args.action_dim,
        hidden_dim=args.hidden_dim,
        in_channels=args.in_channels,
        freeze_backbone=args.freeze_backbone,
    ).to(device)
    print(f"Parameters: {sum(p.numel() for p in model.parameters() if p.requires_grad):,} trainable")

    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=args.epochs)
    criterion = nn.MSELoss()

    # Training loop
    best_val_loss = float("inf")
    os.makedirs(args.save_dir, exist_ok=True)

    for epoch in range(1, args.epochs + 1):
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
            if args.grad_clip > 0:
                nn.utils.clip_grad_norm_(model.parameters(), args.grad_clip)
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
        print(f"Epoch {epoch:03d}/{args.epochs}  train_loss={train_loss:.6f}  val_loss={val_loss:.6f}  lr={lr:.2e}")

        # Save best
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            path = os.path.join(args.save_dir, "best.pt")
            torch.save({"epoch": epoch, "model": model.state_dict(), "val_loss": val_loss}, path)
            print(f"  -> saved best model (val_loss={val_loss:.6f})")

        # Periodic checkpoint
        if epoch % args.save_every == 0:
            path = os.path.join(args.save_dir, f"epoch_{epoch:03d}.pt")
            torch.save({"epoch": epoch, "model": model.state_dict(), "val_loss": val_loss}, path)

    # Save final
    path = os.path.join(args.save_dir, "final.pt")
    torch.save({"epoch": args.epochs, "model": model.state_dict(), "val_loss": val_loss}, path)
    print(f"Training complete. Best val_loss={best_val_loss:.6f}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Train BC-RNN for Spot manipulation")

    # Data
    parser.add_argument("--data", type=str, required=True, help="Path to synced .npy file(s) or directory")
    parser.add_argument("--joint-name", type=str, default="hand", help="TF child frame name")
    parser.add_argument("--seq-len", type=int, default=20, help="Sliding window length")
    parser.add_argument("--val-ratio", type=float, default=0.1, help="Fraction of data for validation")

    # Model
    parser.add_argument("--state-dim", type=int, default=6, help="State dimension (6D pose)")
    parser.add_argument("--action-dim", type=int, default=6, help="Action dimension (6D pose)")
    parser.add_argument("--hidden-dim", type=int, default=256, help="GRU hidden dimension")
    parser.add_argument("--in-channels", type=int, default=1, help="Image input channels (1=grayscale, 3=RGB)")
    parser.add_argument("--image-size", type=int, default=224, help="Image resize (square)")
    parser.add_argument("--freeze-backbone", action="store_true", default=True, help="Freeze ResNet backbone")
    parser.add_argument("--no-freeze-backbone", action="store_false", dest="freeze_backbone")

    # Training
    parser.add_argument("--epochs", type=int, default=200)
    parser.add_argument("--batch-size", type=int, default=16)
    parser.add_argument("--lr", type=float, default=1e-4)
    parser.add_argument("--weight-decay", type=float, default=1e-5)
    parser.add_argument("--grad-clip", type=float, default=1.0, help="Gradient clipping norm (0 to disable)")
    parser.add_argument("--num-workers", type=int, default=4)

    # Saving
    parser.add_argument("--save-dir", type=str, default="checkpoints", help="Directory for model checkpoints")
    parser.add_argument("--save-every", type=int, default=50, help="Save checkpoint every N epochs")

    args = parser.parse_args()
    train(args)


if __name__ == "__main__":
    main()
