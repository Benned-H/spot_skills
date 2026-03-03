"""BC-RNN model with ResNet visual backbone for Spot robot behavior cloning."""

from __future__ import annotations

import torch
import torch.nn as nn
import torchvision.models as models


class BCRNNModel(nn.Module):
    """Behavior cloning RNN model: ResNet image encoder + state MLP + GRU -> action.

    Architecture:
        Image  -> ResNet18 (frozen or finetuned) -> 512-dim feature
        State  -> MLP(state_dim -> 64, ReLU, 64 -> 64) -> 64-dim feature
        Concat -> GRU(576 -> 256) -> Linear(256 -> action_dim) -> action

    During training, call forward() with full sequences.
    During deployment, call step() iteratively with the hidden state.
    """

    def __init__(
        self,
        state_dim: int = 18,
        action_dim: int = 6,
        hidden_dim: int = 256,
        in_channels: int = 1,
        freeze_backbone: bool = True,
    ) -> None:
        super().__init__()
        self.hidden_dim = hidden_dim

        # Visual backbone: ResNet18, drop the final FC layer
        resnet = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)
        if in_channels != 3:
            old_conv = resnet.conv1
            resnet.conv1 = nn.Conv2d(
                in_channels, old_conv.out_channels,
                kernel_size=old_conv.kernel_size,
                stride=old_conv.stride,
                padding=old_conv.padding,
                bias=old_conv.bias is not None,
            )
            # Initialize with mean of pretrained RGB weights
            with torch.no_grad():
                resnet.conv1.weight.copy_(
                    old_conv.weight.mean(dim=1, keepdim=True).repeat(1, in_channels, 1, 1)
                )
        self.image_encoder = nn.Sequential(*list(resnet.children())[:-1])  # -> (B, 512, 1, 1)

        if freeze_backbone:
            for param in self.image_encoder.parameters():
                param.requires_grad = False

        # State encoder
        self.state_encoder = nn.Sequential(
            nn.Linear(state_dim, 64),
            nn.ReLU(),
            nn.Linear(64, 64),
        )

        # Recurrent layer
        self.gru = nn.GRU(input_size=512 + 64, hidden_size=hidden_dim, batch_first=True)

        # Action head
        self.action_head = nn.Linear(hidden_dim, action_dim)

    def _encode(self, image: torch.Tensor, state: torch.Tensor) -> torch.Tensor:
        """Encode image and state into a single feature vector.

        Args:
            image: (B, C, H, W) or (B, T, C, H, W)
            state: (B, state_dim) or (B, T, state_dim)

        Returns:
            (B, 576) or (B, T, 576) combined feature.
        """
        has_time = image.dim() == 5
        if has_time:
            B, T = image.shape[:2]
            image = image.reshape(B * T, *image.shape[2:])
            state = state.reshape(B * T, -1)

        img_feat = self.image_encoder(image).flatten(1)  # (B*T, 512)
        state_feat = self.state_encoder(state)            # (B*T, 64)
        combined = torch.cat([img_feat, state_feat], dim=1)  # (B*T, 576)

        if has_time:
            combined = combined.reshape(B, T, -1)
        return combined

    def forward(
        self,
        image: torch.Tensor,
        state: torch.Tensor,
        hidden: torch.Tensor | None = None,
    ) -> tuple[torch.Tensor, torch.Tensor]:
        """Forward pass over a sequence (for training).

        Args:
            image:  (B, T, C, H, W) image sequence.
            state:  (B, T, state_dim) state sequence.
            hidden: (1, B, hidden_dim) optional initial hidden state.

        Returns:
            actions: (B, T, action_dim) predicted actions.
            hidden:  (1, B, hidden_dim) final hidden state.
        """
        features = self._encode(image, state)         # (B, T, 576)
        gru_out, hidden = self.gru(features, hidden)  # (B, T, hidden_dim)
        actions = self.action_head(gru_out)            # (B, T, action_dim)
        return actions, hidden

    def step(
        self,
        image: torch.Tensor,
        state: torch.Tensor,
        hidden: torch.Tensor | None = None,
    ) -> tuple[torch.Tensor, torch.Tensor]:
        """Single-step forward pass (for deployment).

        Args:
            image:  (B, C, H, W) single image.
            state:  (B, state_dim) single state.
            hidden: (1, B, hidden_dim) hidden state from previous step.

        Returns:
            action: (B, action_dim) predicted action.
            hidden: (1, B, hidden_dim) updated hidden state.
        """
        features = self._encode(image, state)              # (B, 576)
        features = features.unsqueeze(1)                    # (B, 1, 576)
        gru_out, hidden = self.gru(features, hidden)        # (B, 1, hidden_dim)
        action = self.action_head(gru_out.squeeze(1))       # (B, action_dim)
        return action, hidden

    def init_hidden(self, batch_size: int, device: torch.device = None) -> torch.Tensor:
        """Create zero-initialized hidden state."""
        return torch.zeros(1, batch_size, self.hidden_dim, device=device)
