local harpoon = require('harpoon')
local map = vim.keymap.set

harpoon:setup()

map('n', '<leader>ha', function()
  harpoon:list():add()
end, { desc = 'Harpoon add file' })

map('n', '<leader>hh', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon menu' })

map('n', '<leader>h1', function()
  harpoon:list():select(1)
end, { desc = 'Harpoon file 1' })

map('n', '<leader>h2', function()
  harpoon:list():select(2)
end, { desc = 'Harpoon file 2' })

map('n', '<leader>h3', function()
  harpoon:list():select(3)
end, { desc = 'Harpoon file 3' })

map('n', '<leader>h4', function()
  harpoon:list():select(4)
end, { desc = 'Harpoon file 4' })

map('n', '<leader>hp', function()
  harpoon:list():prev()
end, { desc = 'Harpoon previous file' })

map('n', '<leader>hn', function()
  harpoon:list():next()
end, { desc = 'Harpoon next file' })
