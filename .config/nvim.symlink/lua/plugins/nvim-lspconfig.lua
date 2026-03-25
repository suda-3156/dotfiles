-- From: kickstart.nvim
---@type LazyPluginSpec
return {
  "https://github.com/neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
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
