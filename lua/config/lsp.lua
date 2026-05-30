require('mason').setup()

local capabilities = nil
local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink then
  capabilities = blink.get_lsp_capabilities()
end

if capabilities then
  vim.lsp.config('*', {
    capabilities = capabilities,
  })
end

-- Small server-specific adjustments. Add more only when a language needs them.
vim.lsp.config('lua_ls', {
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == '' then
      return
    end

    local config_root = vim.fn.stdpath('config')
    if vim.fs.relpath(config_root, name) then
      on_dir(config_root)
      return
    end

    local root = vim.fs.root(bufnr, {
      { '.emmyrc.json', '.luarc.json', '.luarc.jsonc' },
      { '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
      { '.git' },
    })

    -- Do not let a broad ~/.git make lua_ls treat the whole home directory as
    -- one workspace. lua-language-server refuses such huge directories anyway.
    if root and root ~= vim.env.HOME then
      on_dir(root)
    end
  end,
  on_init = function(client)
    if client.config.root_dir ~= vim.fn.stdpath('config') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
        },
      },
    })
  end,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
    },
  },
})

vim.lsp.config('pyright', {
  settings = {
    pyright = {
      -- Ruff owns import organisation in this setup.
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.config('ruff', {
  init_options = {
    settings = {
      -- Pyright owns parser diagnostics; Ruff owns linting and formatting.
      showSyntaxErrors = false,
      -- Ruff writes INFO/WARN startup messages to stderr; Neovim records those
      -- in the LSP log and then :checkhealth reports scary-looking warnings.
      -- Keep real diagnostics in the editor, but quiet the server log noise.
      logLevel = 'error',
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable Ruff hover in favor of Pyright',
})

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
    },
  },
})

-- Mason bridges installed tools to native vim.lsp.enable(). It installs the
-- baseline servers listed here and automatically enables installed servers.
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'cssls',
    'eslint',
    'gopls',
    'html',
    'jdtls',
    'jsonls',
    'lua_ls',
    'pyright',
    'ruff',
    'rust_analyzer',
    'tailwindcss',
    'ts_ls',
    'vtsls',
    'yamlls',
  },
  -- Avoid running both TypeScript LSPs at once. vtsls is the preferred 2026
  -- TypeScript server here; ts_ls remains installed as a fallback/manual option.
  automatic_enable = {
    exclude = { 'ts_ls' },
  },
})

vim.api.nvim_create_user_command('DevToolsCheck', function()
  local tools = {
    { name = 'git', purpose = 'Git integration' },
    { name = 'fzf', purpose = 'fzf-lua picker UI' },
    { name = 'rg', purpose = 'project text search' },
    { name = 'fd', purpose = 'fast file discovery' },
    { name = 'node', purpose = 'JS/TS language tooling' },
    { name = 'npm', purpose = 'JS/TS language tooling' },
    { name = 'python3', purpose = 'Python tooling' },
    { name = 'go', purpose = 'Go tooling' },
    { name = 'rustup', purpose = 'Rust toolchain' },
    { name = 'cargo', purpose = 'Rust tools / optional builds' },
    { name = 'tree-sitter', purpose = 'nvim-treesitter parser installs' },
    { name = 'clangd', purpose = 'C/C++ LSP' },
    { name = 'clang-format', purpose = 'C/C++ formatting' },
    { name = 'java', purpose = 'Java LSP runtime' },
    { name = 'prettier', purpose = 'fallback Prettier formatter' },
    { name = 'prettierd', purpose = 'fast Prettier formatter' },
    { name = 'curl', purpose = 'Mason and parser downloads' },
    { name = 'tar', purpose = 'Mason and parser installs' },
    { name = 'unzip', purpose = 'Mason installs' },
  }

  local lines = { 'Developer tool check:' }
  for _, tool in ipairs(tools) do
    local path = vim.fn.exepath(tool.name)
    local status = path ~= '' and ('found: ' .. path) or 'missing'
    table.insert(lines, string.format('  %-12s %-8s %s', tool.name, status, tool.purpose))
  end
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end, { desc = 'Check external developer tools used by this config' })
