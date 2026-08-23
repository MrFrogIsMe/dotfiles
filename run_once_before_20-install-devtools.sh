#!/bin/bash
set -eu

OPT_DIR="$HOME/.local/opt"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$OPT_DIR" "$BIN_DIR"

os="$(uname -s)"
arch="$(uname -m)"

gh_latest_asset_url() {
  # $1 = owner/repo   $2 = extended-regex pattern to match one asset's download URL
  curl -fsSL -H "User-Agent: chezmoi-dotfiles" \
    "https://api.github.com/repos/$1/releases/latest" \
    | grep -o '"browser_download_url": *"[^"]*"' \
    | sed -E 's/.*"(https[^"]+)"/\1/' \
    | grep -E "$2" \
    | head -n1
}

# installs a .tar.gz release into $OPT_DIR/<name>
# $3 = --strip-components count (1 = drop the wrapping dir most releases have; 0 = flat archive like fzf)
install_from_tarball() {
  local name="$1" url="$2" strip="${3:-1}"
  if [ -z "$url" ]; then
    echo "devtools: no release asset found for $name on $os-$arch, skipping" >&2
    return 0
  fi
  local dest="$OPT_DIR/$name"
  [ -d "$dest" ] && return 0
  echo "devtools: installing $name from $url"
  local tmp; tmp="$(mktemp -d)"
  curl -fsSL "$url" -o "$tmp/archive.tar.gz"
  mkdir -p "$dest"
  tar -xzf "$tmp/archive.tar.gz" -C "$dest" --strip-components="$strip"
  rm -rf "$tmp"
}

case "$os-$arch" in
  Darwin-arm64)
    nvim_pat='nvim-macos-arm64\.tar\.gz$'
    fd_pat='aarch64-apple-darwin\.tar\.gz$'
    rg_pat='aarch64-apple-darwin\.tar\.gz$'
    fzf_pat='fzf-[0-9.]+-darwin_arm64\.tar\.gz$'
    ;;
  Darwin-x86_64)
    nvim_pat='nvim-macos-x86_64\.tar\.gz$'
    fd_pat='x86_64-apple-darwin\.tar\.gz$'
    rg_pat='x86_64-apple-darwin\.tar\.gz$'
    fzf_pat='fzf-[0-9.]+-darwin_amd64\.tar\.gz$'
    ;;
  Linux-x86_64)
    nvim_pat='nvim-linux64\.tar\.gz$|nvim-linux-x86_64\.tar\.gz$'
    fd_pat='x86_64-unknown-linux-gnu\.tar\.gz$'
    rg_pat='x86_64-unknown-linux-musl\.tar\.gz$'
    fzf_pat='fzf-[0-9.]+-linux_amd64\.tar\.gz$'
    ;;
  Linux-aarch64|Linux-arm64)
    nvim_pat='nvim-linux-arm64\.tar\.gz$'
    fd_pat='aarch64-unknown-linux-gnu\.tar\.gz$'
    rg_pat='aarch64-unknown-linux-gnu\.tar\.gz$'
    fzf_pat='fzf-[0-9.]+-linux_arm64\.tar\.gz$'
    ;;
  *)
    echo "devtools: unsupported platform $os-$arch, skipping nvim/fd/rg/fzf install" >&2
    exit 0
    ;;
esac

install_from_tarball nvim "$(gh_latest_asset_url neovim/neovim "$nvim_pat")" 1
install_from_tarball fd   "$(gh_latest_asset_url sharkdp/fd "$fd_pat")" 1
install_from_tarball rg   "$(gh_latest_asset_url BurntSushi/ripgrep "$rg_pat")" 1
install_from_tarball fzf  "$(gh_latest_asset_url junegunn/fzf "$fzf_pat")" 0

[ -x "$OPT_DIR/nvim/bin/nvim" ] && ln -sf "$OPT_DIR/nvim/bin/nvim" "$BIN_DIR/nvim"
[ -x "$OPT_DIR/fd/fd" ]         && ln -sf "$OPT_DIR/fd/fd" "$BIN_DIR/fd"
[ -x "$OPT_DIR/rg/rg" ]         && ln -sf "$OPT_DIR/rg/rg" "$BIN_DIR/rg"
[ -x "$OPT_DIR/fzf/fzf" ]       && ln -sf "$OPT_DIR/fzf/fzf" "$BIN_DIR/fzf"
