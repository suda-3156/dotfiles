-- LSP server configurations

return {
  -- lua
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' },
        },
        format = {
          enable = false,
        },
      },
    },
  },

  -- infra
  terraformls = {},
  dockerls = {},
  docker_compose_language_service = {},

  -- python
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          mccabe = { enabled = false },
          pylsp_mypy = { enabled = false },
          pylsp_black = { enabled = false },
          pylsp_isort = { enabled = false },
        },
      },
    },
  },

  basedpyright = {
    -- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
    settings = {
      basedpyright = {
        disableOrganizeImports = true, -- Using Ruff's import organizer
        disableLanguageServices = false,
        analysis = {
          ignore = { '*' }, -- Ignore all files for analysis to exclusively use Ruff for linting
          typeCheckingMode = 'off',
          diagnosticMode = 'openFilesOnly', -- Only analyze open files
          useLibraryCodeForTypes = true,
          autoImportCompletions = true, -- whether pyright offers auto-import completions
        },
      },
    },
  },
  ruff = {},

  -- go
  gopls = {},

  -- c/c++
  clangd = {},

  -- web
  html = {
    filetypes = { 'html', 'twig', 'hbs' },
  },
  tailwindcss = {},
  cssls = {},
  graphql = {},

  -- misc
  jsonls = {},
  yamlls = {},
  bashls = {},
  sqlls = {},
  ltex = {},
  texlab = {},
}

