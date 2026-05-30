require('blink.cmp').setup({
  keymap = {
    preset = 'super-tab',
    ['<Esc>'] = { 'hide', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  -- Use Blink's Rust fuzzy matcher when available, falling back with a warning if not.
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
})
