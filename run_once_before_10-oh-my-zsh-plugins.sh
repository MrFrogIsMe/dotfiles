#!/bin/bash
set -eu

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
  local dest="$1" repo="$2"
  [ -d "$dest" ] || git clone --depth=1 "$repo" "$dest"
}

if [ -d "$HOME/.oh-my-zsh" ]; then
  clone_if_missing "$ZSH_CUSTOM/plugins/zsh-autosuggestions" https://github.com/zsh-users/zsh-autosuggestions
  clone_if_missing "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" https://github.com/zsh-users/zsh-syntax-highlighting
  clone_if_missing "$ZSH_CUSTOM/plugins/you-should-use" https://github.com/MichaelAquilina/zsh-you-should-use
  clone_if_missing "$ZSH_CUSTOM/themes/powerlevel10k" https://github.com/romkatv/powerlevel10k
fi

# chucknorris plugin also needs the 'fortune'/'strfile' system package —
# install it yourself via your OS package manager if you want that plugin working.
