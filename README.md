# Matt's Neovim config

Native-first Neovim 0.12+ config managed with `vim.pack`.

## Structure

The Lua config namespace is `config`:

```text
~/.config/nvim/lua/config/
  options.lua
  keymaps.lua
  autocmds.lua
  diagnostics.lua
  plugins.lua
  theme.lua
  lsp.lua
  plugin/
```

The desktop theme module is `config.theme`. It reads `~/.local/state/theme-family` and `~/.local/state/theme-mode`; Neovim does not use a generated `config.base16_active` module.

## First run

Open Neovim:

```sh
nvim
```

`vim.pack` installs the configured plugins into Neovim's data directory. This config uses:

- github-nvim-theme
- flexoki-neovim
- gruvbox.nvim
- modus-themes.nvim
- nightfox.nvim
- token
- mini.clue
- mini.icons
- fzf-lua
- plenary.nvim
- harpoon2
- oil.nvim
- gitsigns.nvim
- nvim-lspconfig
- mason.nvim
- mason-lspconfig.nvim
- blink.cmp v1.10.2
- conform.nvim
- nvim-treesitter

## Useful commands

- `:Oil` — open the editable file explorer.
- `:Mason` — install/manage language servers, formatters and tools.
- `:LspInstall` — install language servers via mason-lspconfig.
- `:checkhealth` — general health report.
- `:checkhealth vim.lsp` — LSP status.
- `:checkhealth mason` — Mason requirements/status.
- `:DevToolsCheck` — simple external tool check for this config.
- `:Format` — format current buffer/range using conform.nvim, falling back to LSP.
- `:TreesitterInstallConfigured` — install the configured Tree-sitter parsers.
- `:ThemeStatus` — show the detected desktop theme family, mode and Neovim colourscheme.
- `:ThemeReload` — reapply the Neovim theme from the state files.
- `:lua vim.pack.update()` — update plugins managed by `vim.pack`.

## Theme switching

Neovim follows the desktop theme state:

- `~/.local/state/theme-family` — selected manually with `theme-family github|flexoki|gruvbox|modus|nightfox|token`
- `~/.local/state/theme-mode` — selected by darkman/`theme-switch light|dark`

New Neovim instances choose the matching official colourscheme plugin:

| Family | Light | Dark |
|---|---|---|
| github | `github_light_default` | `github_dark_default` |
| flexoki | `flexoki-light` | `flexoki-dark` |
| gruvbox | `gruvbox` | `gruvbox` |
| modus | `modus_operandi` | `modus_vivendi` |
| nightfox | `dayfox` | `carbonfox` |
| token | `token` | `token` |

Inside Neovim:

- `:ThemeStatus` shows the detected family/mode/colourscheme.
- `:ThemeReload` reapplies the theme from the state files in an already-running instance.

## External tools

Recommended baseline tools on Fedora:

```sh
sudo dnf install git ripgrep fd-find fzf curl unzip tar gcc tree-sitter-cli
```

Recommended baseline tools on macOS:

```sh
brew install git ripgrep fd fzf curl unzip tree-sitter
```

Install project/language tools through the project where possible. Mason is included for convenience, but the config avoids hardcoded Mason paths.
