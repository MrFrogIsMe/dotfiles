return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        racket_langserver = {},
      },
    },
  },
  {
    "Olical/conjure",
    ft = { "racket", "scheme" },
    lazy = true,
  },
}
