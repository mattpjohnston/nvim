local M = {}

local defaults = {
  family = 'token',
  mode = 'dark',
}

local schemes = {
  github = {
    light = 'github_light_default',
    dark = 'github_dark_default',
  },
  flexoki = {
    light = 'flexoki-light',
    dark = 'flexoki-dark',
  },
  gruvbox = {
    light = 'gruvbox',
    dark = 'gruvbox',
  },
  modus = {
    light = 'modus_operandi',
    dark = 'modus_vivendi',
  },
  nightfox = {
    light = 'dayfox',
    dark = 'carbonfox',
  },
  token = {
    light = 'token',
    dark = 'token',
  },
}

local function read_first_line(path)
  local ok, lines = pcall(vim.fn.readfile, vim.fn.expand(path), '', 1)
  if ok and lines and lines[1] and lines[1] ~= '' then
    return vim.trim(lines[1])
  end
end

local function normalise_mode(mode)
  if mode == 'light' or mode == 'dark' then
    return mode
  end
  return defaults.mode
end

local function normalise_family(family)
  if schemes[family] then
    return family
  end
  return defaults.family
end

function M.current()
  return {
    family = normalise_family(read_first_line('~/.local/state/theme-family')),
    mode = normalise_mode(read_first_line('~/.local/state/theme-mode')),
  }
end

function M.scheme_for(family, mode)
  family = normalise_family(family)
  mode = normalise_mode(mode)
  return schemes[family][mode]
end

local function configure_plugin(family)
  if family == 'github' then
    local ok_github, github = pcall(require, 'github-theme')
    if ok_github then
      github.setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = 'NONE',
            functions = 'NONE',
            keywords = 'NONE',
            variables = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
          },
        },
      })
    end
    return
  end

  if family == 'flexoki' then
    local ok_flexoki, flexoki = pcall(require, 'flexoki')
    if ok_flexoki then
      flexoki.setup({
        variant = 'auto',
        dark_variant = 'dark',
        light_variant = 'light',
      })
    end
    return
  end

  if family == 'gruvbox' then
    local ok_gruvbox, gruvbox = pcall(require, 'gruvbox')
    if ok_gruvbox then
      gruvbox.setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,
        contrast = '',
        dim_inactive = false,
        transparent_mode = false,
      })
    end
    return
  end

  if family == 'modus' then
    local ok_modus, modus = pcall(require, 'modus-themes')
    if ok_modus then
      modus.setup({
        style = 'auto',
        variants = {
          modus_operandi = 'default',
          modus_vivendi = 'default',
        },
        transparent = false,
        dim_inactive = false,
        line_nr_column_background = true,
        sign_column_background = true,
        styles = {
          comments = {},
          keywords = {},
          functions = {},
          variables = {},
        },
      })
    end
    return
  end

  if family == 'nightfox' then
    local ok_nightfox, nightfox = pcall(require, 'nightfox')
    if ok_nightfox then
      nightfox.setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            functions = 'NONE',
            keywords = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
            variables = 'NONE',
          },
        },
      })
    end
  end
end

function M.apply()
  local current = M.current()
  vim.o.background = current.mode

  configure_plugin(current.family)

  local scheme = M.scheme_for(current.family, current.mode)
  local ok, err = pcall(vim.cmd.colorscheme, scheme)
  if not ok then
    vim.notify(
      string.format('Failed to load colourscheme %s: %s', scheme, err),
      vim.log.levels.ERROR
    )
    return false
  end

  return true
end

vim.api.nvim_create_user_command('ThemeStatus', function()
  local current = M.current()
  print(string.format(
    'family=%s mode=%s colorscheme=%s',
    current.family,
    current.mode,
    M.scheme_for(current.family, current.mode)
  ))
end, { desc = 'Show desktop-driven Neovim theme state' })

vim.api.nvim_create_user_command('ThemeReload', function()
  M.apply()
end, { desc = 'Reload Neovim theme from ~/.local/state/theme-*' })

return M

