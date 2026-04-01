#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Symlinks created."
