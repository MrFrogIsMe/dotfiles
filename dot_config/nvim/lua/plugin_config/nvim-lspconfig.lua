-- Setup language servers.
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local cmp = require "cmp"

lsps = {
    { "pyright" }, 
    { "ruff" },
    { 
        "clangd",
        {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            cmd = {
                "clangd",
                "--offset-encoding=utf-16",
            }
        }
    },
    { "csharp_ls" },
    { "ts_ls" },
    { "marksman" },
    { "gopls" },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

-- Format on write
-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<Leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>w', function()
      vim.lsp.buf.format { async = true }
    end, opts)
--    -- format on save
--    vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = group })
--    vim.api.nvim_create_autocmd(event, {
--      buffer = ev.buf,
--      group = group,
--      callback = function()
--        vim.lsp.buf.format({ bufnr = ev.buf, async = async })
--      end,
--      desc = "[lsp] format on save",
--    })
  end,
})

vim.fn.sign_define(
  'DiagnosticSignError',
  { text = '', texthl = 'LspDiagnosticsDefaultError' }
)

vim.fn.sign_define(
  'DiagnosticSignWarn',
  { text = '', texthl = 'LspDiagnosticsDefaultWarning' }
)

vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '', texthl = 'LspDiagnosticsDefaultInformation' }
)

vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'LspDiagnosticsDefaultHint' }
)

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
