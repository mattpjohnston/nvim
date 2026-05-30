-- Install and load plugins with Neovim's built-in package manager.
-- New installs ask for confirmation in interactive sessions; headless verification can pass --headless and already-installed plugins are reused.
vim.pack.add({
  { src = 'https://github.com/projekt0n/github-nvim-theme' },
  { src = 'https://github.com/kepano/flexoki-neovim', name = 'flexoki' },
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/miikanissi/modus-themes.nvim' },
  { src = 'https://github.com/EdenEast/nightfox.nvim' },
  { src = 'https://github.com/ThorstenRhau/token' },
  { src = 'https://github.com/nvim-mini/mini.clue' },
  { src = 'https://github.com/echasnovski/mini.icons' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/Saghen/blink.cmp', name = 'blink.cmp', version = 'v1.10.2' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}, { confirm = false })

require('config.theme').apply()

require('config.plugin.ui')
require('config.plugin.oil')
require('config.plugin.picker')
require('config.plugin.harpoon')
require('config.plugin.git')
require('config.plugin.completion')
require('config.plugin.formatting')
require('config.plugin.treesitter')
