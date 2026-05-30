local actions = require('fzf-lua.actions')

require('fzf-lua').setup({
  'default-title',
  winopts = {
    height = 0.85,
    width = 0.90,
    preview = {
      layout = 'flex',
    },
  },
  fzf_opts = {
    ['--layout'] = 'reverse',
    ['--info'] = 'inline',
  },
  keymap = {
    builtin = {
      ['<F4>'] = 'toggle-preview',
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
      ['<C-f>'] = 'preview-page-down',
      ['<C-b>'] = 'preview-page-up',
    },
    fzf = {
      ['ctrl-u'] = 'unix-line-discard',
      ['ctrl-a'] = 'beginning-of-line',
      ['ctrl-e'] = 'end-of-line',
      ['alt-a'] = 'toggle-all',
    },
  },
  actions = {
    files = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-s'] = actions.file_split,
      ['ctrl-v'] = actions.file_vsplit,
      ['ctrl-t'] = actions.file_tabedit,
      ['alt-q'] = actions.file_sel_to_qf,
    },
    buffers = {
      ['default'] = actions.buf_edit,
      ['ctrl-s'] = actions.buf_split,
      ['ctrl-v'] = actions.buf_vsplit,
      ['ctrl-t'] = actions.buf_tabedit,
      ['ctrl-x'] = actions.buf_del,
    },
  },
  files = {
    fd_opts = '--color=never --type f --hidden --follow --exclude .git',
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g '!.git'",
  },
  oldfiles = {
    cwd_only = false,
  },
})

-- Use fzf-lua for built-in selection prompts where possible, including some LSP choices.
require('fzf-lua').register_ui_select()
