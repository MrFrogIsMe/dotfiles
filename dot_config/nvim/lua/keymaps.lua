vim.g.mapleader = ' '

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamed,unnamedplus"
-- vim.opt.spell = true
-- vim.opt.spelllang = 'en_us'
vim.cmd [[
  autocmd BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx,*.html,*.md,*.py setlocal tabstop=2 shiftwidth=2
]]


vim.opt.nu = true
vim.opt.rnu = true
vim.opt.ruler = true

local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }

keyset('n', 'i', ':nohls<CR>i', opts)
keyset('n', 'I', ':nohls<CR>I', opts)
keyset('n', 'a', ':nohls<CR>a', opts)
keyset('n', 'A', ':nohls<CR>A', opts)
keyset('n', 'o', ':nohls<CR>o', opts)
keyset('n', 'O', ':nohls<CR>O', opts)

-- Better window navigation
-- keyset('n', '<C-h>', '<c-w>h', opts)
-- keyset('n', '<C-j>', '<c-w>j', opts)
-- keyset('n', '<C-k>', '<c-w>k', opts)
-- keyset('n', '<C-l>', '<c-w>l', opts)
keyset('n', '<M-h>', '<c-w>h', opts)
keyset('n', '<M-j>', '<c-w>j', opts)
keyset('n', '<M-k>', '<c-w>k', opts)
keyset('n', '<M-l>', '<c-w>l', opts)
keyset('t', '<M-h>', '<C-\\><C-n><c-w>h', opts)
keyset('t', '<M-j>', '<c-\\><C-n><c-w>j', opts)
keyset('t', '<M-k>', '<c-\\><C-n><c-w>k', opts)
keyset('t', '<M-l>', '<c-\\><C-n><c-w>l', opts)

-- Resize with arrows
keyset('n', '<S-Up>', ':resize -2<CR>', opts)
keyset('n', '<S-Down>', ':resize +2<CR>', opts)
keyset('n', '<S-Left>', ':vertical resize -2<CR>', opts)
keyset('n', '<S-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
--keyset('n', '<M-l>', ':bnext<CR>', opts)
--keyset('n', '<M-h>', ':bprevious<CR>', opts)

-- Navigate tabs
keyset('n', '<S-l>', ':tabn<CR>', opts)
keyset('n', '<S-h>', ':tabN<CR>', opts)
-- keyset('n', '<Tab>', ':tabn<CR>', opts)
-- keyset('n', '<S-Tab>', ':tabN<CR>', opts)

-- Tab operations
keyset('n', '<Leader>tn', ':tabnew<CR>', opts)
keyset('n', '<Leader>ta', ':tabnew<CR>', opts)
keyset('n', '<Leader>tc', ':tabclose<CR>', opts)
keyset('n', '<Leader>tx', ':tabclose<CR>', opts)
keyset('n', '<Leader>te', ':tabedit<SPACE>', {noremap = true})
keyset('n', '<Leader>tm', ':tabmove<SPACE>', {noremap = true})
keyset('n', '<Leader>tg', ':BufferLinePick<CR>', opts)

-- Stay in indent mode
keyset('v', '>', '>gv', opts)
keyset('v', '<', '<gv', opts)

-- Exit terminal-mode
keyset('t', '<Esc>', '<C-\\><C-n>', opts)
keyset('t', 'jj', '<C-\\><C-n>', opts)
-- keyset('t', 'jk', '<C-\\><C-n>', opts)

-- Exit Insert-mode
keyset('i', 'jj', '<Esc>', opts)
keyset('i', 'jk', '<Esc>', opts)

-- Add Terminal tab
keyset('n', '<Leader>tt', ':tabnew<CR>:terminal<CR>i', opts)

-- Split terminal
keyset('n', '<Leader>tv', ':vne<CR><C-w>L:vert res 40<CR>:terminal<CR>i', opts)
keyset('n', '<Leader>ts', ':new<CR><C-w>J:res 10<CR>:terminal<CR>i', opts)

-- Split window
keyset('n', '<Leader>sv', ':vne<CR><C-w>L', opts)
keyset('n', '<Leader>ss', ':new<CR><C-w>J', opts)
