#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# tmux
if [ -e "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
    echo "~/.tmux.conf already exists, please remove it first."
else
    ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    echo "tmux symlink created success"
fi

# vim
if [ -e "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]; then
    echo "~/.vimrc already exists, please remove it first."
else
    ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
    echo "vim symlink created success"
fi

echo "finish"
