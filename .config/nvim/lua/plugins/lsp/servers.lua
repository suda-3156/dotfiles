-- LSP server configurations

return {
  -- lua
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        },
        completion = {
          callSnippet = 'Replace',
        },
        telemetry = { enable = false },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },

  -- infra
  terraformls = {},
  dockerls = {},
  docker_compose_language_service = {},

  -- python
  pyright = {
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

  -- go
  gopls = {},

  -- web
  html = {
    filetypes = { 'html', 'twig', 'hbs' },
  },
  tailwindcss = {},
  cssls = {},
  graphql = {},
  prettierd = {},

  -- misc
  jsonls = {},
  yamlls = {},
  bashls = {},
  sqlls = {},
}
