local opt = vim.opt

-- Editing and indentation. EditorConfig and ftplugins can override these per project/filetype.
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Line display.
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.wrap = false
opt.breakindent = true
opt.scrolloff = 5
opt.sidescrolloff = 8

-- Search.
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'

-- Splits.
opt.splitright = true
opt.splitbelow = true

-- Persistence and safety.
opt.undofile = true
-- Keep swapfile/writebackup defaults for crash recovery and safer writes.
opt.backup = false

-- Responsiveness and mapped key sequences.
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 500

-- Completion and command-line completion. Completion plugins may refine this.
opt.completeopt = { 'menu', 'popup', 'noselect' }
opt.wildoptions:append('pum')
if vim.fn.has('nvim-0.12') == 1 then
  opt.wildoptions:append('fuzzy')
end

-- Whitespace visibility is available via toggle but not always on.
opt.list = false
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '›',
  precedes = '‹',
}

-- Clipboard: use system clipboard when a provider is likely available.
if vim.fn.has('clipboard') == 1 or vim.fn.executable('wl-copy') == 1 or vim.fn.executable('xclip') == 1 or vim.fn.executable('xsel') == 1 or vim.fn.executable('pbcopy') == 1 then
  opt.clipboard = 'unnamedplus'
end

-- True colour is expected by modern terminals/themes. If this looks wrong in a constrained terminal, set it off locally.
opt.termguicolors = true

-- UK English, but do not spell-check code by default.
opt.spelllang = 'en_gb'

-- Keep folding simple initially; avoid surprising Tree-sitter folds by default.
opt.foldenable = false
