local map = vim.keymap.set

map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write file' })
map('n', '<leader>qq', '<cmd>quit<cr>', { desc = 'Quit window' })
map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
map('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Open file explorer' })

-- Finder/search mappings are intentionally described by user intent, not plugin name.
map('n', '<leader>ff', function() require('fzf-lua').files() end, { desc = 'Find files' })
map('n', '<leader>fF', function() require('fzf-lua').git_files() end, { desc = 'Find git files' })
map('n', '<leader>fg', function() require('fzf-lua').live_grep() end, { desc = 'Search text' })
map('n', '<leader>fG', function() require('fzf-lua').live_grep_glob() end, { desc = 'Search text with glob' })
map('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = 'Find buffers' })
map('n', '<leader>fh', function() require('fzf-lua').help_tags() end, { desc = 'Find help' })
map('n', '<leader>fr', function() require('fzf-lua').oldfiles() end, { desc = 'Find recent files' })
map('n', '<leader>fc', function() require('fzf-lua').commands() end, { desc = 'Find commands' })
map('n', '<leader>fd', function() require('fzf-lua').diagnostics_document() end, { desc = 'Find document diagnostics' })
map('n', '<leader>fD', function() require('fzf-lua').diagnostics_workspace() end, { desc = 'Find workspace diagnostics' })

map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
map('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { desc = 'Delete other buffers' })

map('n', '<leader>qo', '<cmd>copen<cr>', { desc = 'Open quickfix list' })
map('n', '<leader>qc', '<cmd>cclose<cr>', { desc = 'Close quickfix list' })
map('n', '<leader>lo', '<cmd>lopen<cr>', { desc = 'Open location list' })
map('n', '<leader>lc', '<cmd>lclose<cr>', { desc = 'Close location list' })

map('n', '<leader>lf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
map('v', '<leader>lf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format selection' })
map('n', '<leader>li', '<cmd>checkhealth vim.lsp<cr>', { desc = 'Show LSP health' })
map('n', '<leader>lr', '<cmd>lsp restart<cr>', { desc = 'Restart LSP' })
map('n', '<leader>ls', function() require('fzf-lua').lsp_document_symbols() end, { desc = 'Find document symbols' })
map('n', '<leader>lS', function() require('fzf-lua').lsp_workspace_symbols() end, { desc = 'Find workspace symbols' })
map('n', '<leader>ld', function() vim.diagnostic.setqflist() end, { desc = 'Diagnostics to quickfix' })

map('n', '<leader>gs', function() require('fzf-lua').git_status() end, { desc = 'Git status' })
map('n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', { desc = 'Git blame line' })
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'Git preview hunk' })
map('n', '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', { desc = 'Git stage hunk' })
map('v', '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', { desc = 'Git stage hunk' })
map('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'Git reset hunk' })
map('v', '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'Git reset hunk' })
map('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'Git diff current file' })

map('n', '<leader>tw', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Wrap ' .. (vim.wo.wrap and 'on' or 'off'))
end, { desc = 'Toggle wrap' })
map('n', '<leader>tl', function()
  vim.wo.list = not vim.wo.list
  vim.notify('Whitespace ' .. (vim.wo.list and 'visible' or 'hidden'))
end, { desc = 'Toggle visible whitespace' })
map('n', '<leader>ts', function()
  vim.wo.spell = not vim.wo.spell
  vim.notify('Spell check ' .. (vim.wo.spell and 'on' or 'off'))
end, { desc = 'Toggle spell check' })
map('n', '<leader>tn', function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = vim.wo.number
  vim.notify('Line numbers ' .. (vim.wo.number and 'on' or 'off'))
end, { desc = 'Toggle line numbers' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
