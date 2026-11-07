-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- nvim-treesitter (main branch) ships no standalone "jsonc" parser;
-- reuse the "json" parser for jsonc filetypes instead of erroring.
vim.treesitter.language.register("json", "jsonc")
