require('mini.icons').setup()

require('oil').setup({
  default_file_explorer = true,
  columns = { 'icon' },
  delete_to_trash = false,
  skip_confirm_for_simple_edits = false,
  view_options = {
    show_hidden = false,
  },
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = false,
  },
  use_default_keymaps = true,
})
