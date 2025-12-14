-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    {
      'j-hui/fidget.nvim',
      tag = 'v1.4.0',
      opts = {
        progress = {
          display = {
            done_icon = '✓', -- Icon shown when all LSP progress tasks are complete
          },
        },
        notification = {
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
  },

  config = function()
    local servers = require('plugins.lsp.servers')
    local keymaps = require('plugins.lsp.keymaps')
    local diagnostics = require('plugins.lsp.diagnostics')

    -- Set keymaps when LSP attaches
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = keymaps.on_attach,
    })

    -- Diagnostic settings
    diagnostics.setup()

    -- LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Mason setup
    require('mason').setup()

    -- Ensure the servers above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- mason-lspconfig setup
    require('mason-lspconfig').setup {
      -- mason-lspconfig calls these handlers when setting up each LSP server
      handlers = {
        function(server_name) -- e.g. 'lua_ls', 'basedpyright', etc.
          local server = servers[server_name] or {} -- Get server settings from servers.lua
          -- Add capabilities to server settings
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          -- Setup the server with lspconfig
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
