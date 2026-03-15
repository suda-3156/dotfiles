return {
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "simple",
      transparent_bg = true,
    })
    vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
  end,
}
