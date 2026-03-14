-- From: kickstart.nvim
---@type LazyPluginSpec
return {
  "https://github.com/neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    --   {
    --     "https://github.com/mason-org/mason.nvim",
    --     ---@module 'mason.settings'
    --     ---@type MasonSettings
    --     ---@diagnostic disable-next-line: missing-fields
    --     opts = {},
    --   },
    --   -- Maps LSP server names between nvim-lspconfig and Mason package names.
    --   "https://github.com/mason-org/mason-lspconfig.nvim",
    --   "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    {
      "https://github.com/j-hui/fidget.nvim",
      opts = {
        progress = { display = { done_icon = "✓" } },
        notification = { window = { winblend = 0 } },
      },
    },
  },
}
