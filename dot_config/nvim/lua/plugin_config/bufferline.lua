vim.opt.termguicolors = true

require('bufferline').setup {
  options = {
    mode = "tabs",
    separator_style = 'slant',
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
    -- hover = {
    --   enabled = true,
    --   delay = 200,
    --   reveal = {'close'}
    -- },
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
        separator = true -- use a "true" to enable the default, or set your own character
      }
    }
  },
  highlights = {
    separator = {
      guifg = '#073642',
      guibg = '#002b36',
    },
    separator_selected = {
      guifg = '#073642',
    },
    background = {
      guifg = '#657b83',
      guibg = '#002b36'
    },
    buffer_selected = {
      guifg = '#fdf6e3',
      gui = "bold",
    },
    fill = {
      guibg = '#073642'
    }
  },
}

-- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
-- vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
