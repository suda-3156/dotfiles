return {
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
