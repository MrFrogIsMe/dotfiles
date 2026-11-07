-- 預設文字模式（render-markdown + latex2text）；<leader>uM 手動切換成圖片模式（snacks.image + tectonic）
return {
  {
    "folke/snacks.nvim",
    opts = { image = { math = { enabled = false } } },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local latex = require("config.latex")
          Snacks.toggle({
            name = "LaTeX 公式圖片",
            get = latex.is_image,
            set = latex.set,
          }):map("<leader>uM")
        end,
      })
    end,
  },
}
