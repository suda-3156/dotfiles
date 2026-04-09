local p = {}

-- From: kickstart.nvim
---@type LazyPluginSpec
p[#p + 1] = {
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

p[#p + 1] = {
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  enabled = false,
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "simple",
      transparent_bg = true,
    })
    vim.diagnostic.config({ virtual_text = true }) -- Disable Neovim's default virtual text diagnostics
  end,
}

return p
