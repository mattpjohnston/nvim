require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

local parsers = {
  'bash',
  'c',
  'cpp',
  'css',
  'go',
  'gomod',
  'gosum',
  'html',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

vim.api.nvim_create_user_command('TreesitterInstallConfigured', function()
  local ok, treesitter = pcall(require, 'nvim-treesitter')
  if not ok then
    vim.notify('nvim-treesitter is not available', vim.log.levels.ERROR)
    return
  end
  treesitter.install(parsers)
end, { desc = 'Install configured Tree-sitter parsers' })
