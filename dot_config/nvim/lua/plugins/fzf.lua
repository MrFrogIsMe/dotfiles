return {
  -- Pin fzf-lua near LazyVim's fzf extra commit date to fix
  -- ":CopilotChatModels" crash (fzf_opts nil in LazyVim fzf.lua ui_select)
  { "ibhagwan/fzf-lua", commit = "988416cc782dfe28bff3f0da9b8c943b236cd86a" },
}
