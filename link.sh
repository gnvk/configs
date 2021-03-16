#!/usr/bin/env bash
set -eux

script=$(realpath "$0")
dir=$(dirname "$script")

ln -s -f "$dir/tmux.conf" ~/.tmux.conf
ln -s -f "$dir/zshrc.sh"  ~/.zshrc
ln -s -f "$dir/p10k.zsh"  ~/.p10k.zsh
ln -s -f "$dir/linux.sh"  ~/.zshrc.linux
ln -s -f "$dir/mac.sh"    ~/.zshrc.mac

if [ -f "$dir/custom.sh" ]; then
  ln -s -f  "$dir/custom.sh"  ~/.zshrc.custom
fi
