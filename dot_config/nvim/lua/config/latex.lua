-- LaTeX 公式顯示模式
--   text  = render-markdown + latex2text（Unicode 文字，任何終端機可用，預設）
--   image = snacks.image + tectonic（圖片，需要支援 kitty graphics 的終端機，如 Ghostty）
-- 兩者同時開會重複處理公式，所以切換時一邊開、一邊關。
local M = {}

function M.is_image()
  return vim.g.latex_render_mode == "image"
end

-- snacks 的 inline 圖片掛在 BufWinEnter 時重算，觸發一次即可刷新已開啟的 buffer
local function refresh_images()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.b[buf].snacks_image_attached then
      vim.api.nvim_exec_autocmds("BufWinEnter", { buffer = buf })
    end
  end
end

---@param image boolean true = 圖片模式，false = 文字模式
function M.set(image)
  if image and not Snacks.image.supports_terminal() then
    vim.notify("此終端機不支援 kitty graphics，維持文字模式", vim.log.levels.WARN, { title = "LaTeX" })
    return
  end
  vim.g.latex_render_mode = image and "image" or "text"
  Snacks.image.config.math.enabled = image

  -- render-markdown 的 setup 會重置全域 enabled 與 buffer 快取，先記住狀態再還原
  local api = require("render-markdown.api")
  local was_enabled = api.get()
  local opts = LazyVim.opts("render-markdown.nvim")
  opts.latex = vim.tbl_extend("force", opts.latex or {}, { enabled = not image })
  require("render-markdown").setup(opts)
  api.set(was_enabled)

  refresh_images()
end

return M
