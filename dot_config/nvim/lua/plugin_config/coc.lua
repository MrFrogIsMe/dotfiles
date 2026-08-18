local keyset = vim.keymap.set

keyset('i', '<Tab>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.Tabout()', { expr = true, silent = true })
keyset('i', '<S-Tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', { expr = true, silent = true })
keyset('i', '<Cr>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<Cr>"', { expr = true, silent = true })
-- Use <c-n> to trigger completion
keyset('i', '<c-n>', 'coc#refresh()', { expr = true, silent = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Remap <C-d> and <C-u> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
keyset("n", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
keyset("i", "<C-d>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-u>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
keyset("v", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)

function Tabout ()
    local dict = {[')'] = 1, [']'] = 1, ['}'] = 1, ["'"] = 1, ['"'] = 1, [';'] = 1}
    --local currChar = vim.fn.getline('.')[vim.fn.col('.')-1]
    local line = vim.fn.getline('.')
    local currPos = vim.fn.col('.')
    local currChar = string.sub(line, currPos, currPos)
    if dict[currChar] then
        return "<Right>"
    else
        return "<Tab>"
    end
end
