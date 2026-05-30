vim.diagnostic.config({
  underline = true,
  signs = true,
  severity_sort = true,
  virtual_text = {
    spacing = 2,
    source = 'if_many',
    prefix = '●',
  },
  virtual_lines = false,
  float = {
    border = 'rounded',
    source = true,
  },
})
