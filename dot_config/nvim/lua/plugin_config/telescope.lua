local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fc', '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>', { desc = "Live Grep Code"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help Tags"})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find Symbols"})
-- vim.keymap.set('n', '<leader>fi', '<cmd>AdvancedGitSearch<CR>', { desc = "AdvancedGitSearch"})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Find Old Files"})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Find Word under Cursor"})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Search Git Commits"})
vim.keymap.set('n', '<leader>gb', builtin.git_bcommits, { desc = "Search Git Commits for Buffer"})


local telescope = require('telescope')
local actions   = require('telescope.actions')
local previewers = require('telescope.previewers')

telescope.setup{
  defaults = {
    color_devicons = true,
    set_env = {COLORTERM = 'truecolor'},
    -- vimgrep_arguments = {
    --   'ag',
    --   '--column',
    --   '--numbers',
    --   '--noheading',
    --   '--nocolor',
    -- },
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    file_ignore_patterns = {"node_modules", "target", ".git"},
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  },
  pickers = {
  },
  extensions = {
  },
}

-- telescope.load_extension('packer')
-- telescope.load_extension('project')
-- telescope.load_extension('session-lens')
-- telescope.load_extension('env')
-- telescope.load_extension('file_browser')
-- telescope.load_extension('luasnip')
-- telescope.load_extension('notify')

-- vim: ts=2 sw=2 et:
