require('conform').setup({
  formatters_by_ft = {
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    lua = { 'stylua' },
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    go = { 'goimports', 'gofmt' },
    java = { lsp_format = 'prefer' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    scss = { 'prettierd', 'prettier', stop_after_first = true },
    less = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    jsonc = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
    graphql = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'shfmt' },
  },
})

vim.api.nvim_create_user_command('Format', function(args)
  require('conform').format({
    async = true,
    lsp_format = 'fallback',
    range = args.range ~= 0 and {
      start = { args.line1, 0 },
      ['end'] = { args.line2, 0 },
    } or nil,
  })
end, { range = true, desc = 'Format current buffer or range' })
