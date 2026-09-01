#!/bin/bash
set -eu

export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

if [ ! -d "$ZSH" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
