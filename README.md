# dotfiles

用 [chezmoi](https://www.chezmoi.io) 管理的個人設定，日常環境是 macOS（Apple Silicon）。bootstrap 腳本另外寫了 Linux x86_64 與 arm64 的分支。

## 內容

| source（本 repo） | 套用到 | 說明 |
|---|---|---|
| `dot_zshenv` | `~/.zshenv` | XDG 路徑，以及各工具的設定與快取位置 |
| `dot_config/zsh/` | `~/.config/zsh/` | `.zshrc`、`.zprofile`，oh-my-zsh + powerlevel10k |
| `dot_config/p10k/` | `~/.config/p10k/` | powerlevel10k 設定 |
| `dot_config/tmux/` | `~/.config/tmux/` | tpm、catppuccin mocha、`allow-passthrough` |
| `dot_config/nvim/` | `~/.config/nvim/` | LazyVim，見下方 nvim 一節 |
| `dot_config/private_git/` | `~/.config/git/` | git config 與全域 ignore |
| `dot_config/gh/`、`docker/`、`gcloud/`、`pip/` | 同名目錄 | CLI 工具設定，不含憑證 |
| `dot_config/opencode/`、`pi/` | 同名目錄 | AI coding 工具的設定與指令 |
| `dot_config/yazi/`、`btop/`、`fish/`、`ccstatusline/`、`cliamp/`、`linearmouse/`、`stormy/`、`private_sqlit/` | 同名目錄 | 其他工具 |
| `private_dot_local/private_share/oh-my-zsh/custom/` | `~/.local/share/oh-my-zsh/custom/` | 自訂 alias 與 `run-code` 指令 |
| `run_once_before_*.sh` | 不會落地 | 新機器第一次 apply 時安裝工具 |

## 設計

### 家目錄 XDG 化

`dot_zshenv` 先定義 `XDG_CONFIG_HOME`、`XDG_DATA_HOME`、`XDG_STATE_HOME`、`XDG_CACHE_HOME`，再把 zsh 和其他工具的位置指過去：

- zsh：`ZDOTDIR` 指到 `~/.config/zsh`，`HISTFILE` 放在 state 目錄，oh-my-zsh 放在 `~/.local/share/oh-my-zsh`
- npm、Rust、Go、GnuPG、Docker、boto、tldr、keras 各自改用 XDG 目錄
- Claude Code（`CLAUDE_CONFIG_DIR`）、Codex（`CODEX_HOME`）、pi（`PI_CODING_AGENT_DIR`）的設定也放在 `~/.config/`

zsh 要先讀到 `~/.zshenv` 才知道 `ZDOTDIR`，所以這個檔案必須留在家目錄。

### 新機器自動安裝

`run_once_before_*.sh` 在第一次 `chezmoi apply` 時、套用檔案之前執行，每個腳本檢查目標是否已存在，重跑不會重複安裝：

1. `05`：安裝 oh-my-zsh 到 XDG 路徑（`RUNZSH=no CHSH=no KEEP_ZSHRC=yes`，不改 shell、不蓋掉 `.zshrc`）
2. `10`：clone zsh-autosuggestions、zsh-syntax-highlighting、you-should-use、powerlevel10k
3. `20`：從 GitHub releases 下載 nvim、fd、ripgrep、fzf，解壓到 `~/.local/opt/`，再 symlink 到 `~/.local/bin/`。依 `uname` 挑選 Darwin / Linux 與 arm64 / x86_64 的檔名

腳本 `20` 抓的是最新 release，沒有鎖版本，也沒有驗證 checksum。

### 憑證不進 repo

這個 repo 是公開的，處理方式如下：

- `gh` 的 token 存在 keychain，`hosts.yml` 只記帳號和 protocol
- `docker/config.json` 使用 `credsStore`，`auths` 是空的
- `gcloud/boto` 只放空白的 `[Credentials]` 範本，實際值在本機另外填
- `private_` 前綴只代表套用後檔案權限為 `0600`，檔案內容在 repo 裡仍然看得到。有憑證的檔案不能只靠這個前綴

### nvim

[LazyVim](https://www.lazyvim.org) 的標準結構，沒有放自己的 `plugin_config/` 之類的目錄：

```
nvim/
├── init.lua                  只 require("config.lazy")
├── lazyvim.json              extras 清單
├── lazy-lock.json            外掛版本，一併追蹤
├── stylua.toml
└── lua/
    ├── config/               autocmds、keymaps、lazy、options，只放和 LazyVim 預設不同的部分
    │   └── latex.lua         LaTeX 公式顯示模式的切換邏輯
    └── plugins/              一個檔案一個主題，lazy.nvim 自動載入
```

幾個值得說明的選擇：

- **LaTeX 公式有兩種顯示方式**。預設用 render-markdown + `latex2text` 轉成 Unicode 文字，所有終端機都能用。在支援 kitty graphics 的終端機（Ghostty）按 `<leader>uM` 可切換成 snacks.image + tectonic 的圖片，再按一次切回來。不支援的終端機按下去會跳警告並維持文字。
- **markdown 預覽用 [sammaji/markdown-preview.nvim](https://github.com/sammaji/markdown-preview.nvim)**。原本的 iamcco/markdown-preview.nvim 在 2024/07 之後沒有更新，內建的 mermaid 太舊。`lua/plugins/markdown-preview.lua` 只有一個 spec，lazy 依外掛名稱合併，會蓋掉 LazyVim extra 裡的來源。
- **fzf-lua 釘在特定 commit**，原因寫在 `lua/plugins/fzf.lua` 的註解裡。

### tmux 與終端機圖片

`tmux.conf` 設了 `allow-passthrough on`，讓 nvim 在 tmux 裡也能用 kitty graphics 顯示圖片。

## 新機器安裝

需要 `curl` 和 `git`。

```sh
brew install chezmoi          # 或 sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init MrFrogIsMe/dotfiles
chezmoi diff                  # 先看會改什麼
chezmoi apply
```

第一次 apply 會跑 `run_once_before_*.sh`，需要網路。oh-my-zsh 的 chucknorris 外掛另外需要系統套件 `fortune` / `strfile`，要自己裝。

## 常用指令

| 目的 | 指令 |
|---|---|
| 看哪些檔案和 source 不同 | `chezmoi status` |
| 看具體差異 | `chezmoi diff` |
| 把 source 套用到家目錄 | `chezmoi apply` |
| 把家目錄裡改過的檔案存回 source | `chezmoi re-add <path>` |
| 開始追蹤新檔案或目錄 | `chezmoi add <path>` |
| 用編輯器改 source 裡的檔案 | `chezmoi edit <path>` |
| 停止追蹤（不刪家目錄的檔案） | `chezmoi forget <path>` |
| 進入 source 目錄 | `chezmoi cd` |
| 列出所有被追蹤的檔案 | `chezmoi managed` |
| 檢查環境與設定 | `chezmoi doctor` |
| 從遠端拉最新並套用 | `chezmoi update` |

`chezmoi apply` 和 `chezmoi update` 會用 source 覆蓋家目錄的檔案。直接在家目錄改過設定的話，先跑 `chezmoi status`，再用 `re-add` 存回 source，最後才 apply，否則改動會被蓋掉。

## 日常流程

1. 直接改家目錄裡的設定（例如 `~/.config/nvim/...`）
2. `chezmoi status` 確認有哪些檔案變動
3. `chezmoi re-add <path>`；新增檔案用 `chezmoi add <path>`；刪除的檔案要同時從 source 移除，或用 `chezmoi forget`
4. `chezmoi cd`，然後 `git add -A && git commit && git push`

## 尚未納入

- Homebrew 套件清單（還沒有 Brewfile）
- Ghostty 設定（macOS 上在 `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`）
- Claude Code 設定（`~/.config/claude`，目錄內有大量對話紀錄與快取，只有部分檔案適合追蹤）
- `.zshrc` 底部 gcloud SDK 的兩行 `source` 寫死了 `/Users/pengqize`，換使用者名稱時需要改
