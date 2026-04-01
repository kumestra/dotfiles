#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# tmux
if [ -e "$HOME/.tmux.conf" ]; then
    echo "~/.tmux.conf already exists, please remove it first."
    exit 1
fi
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Symlinks created."
