---@type LazyPluginSpec
return {
  "https://github.com/folke/zen-mode.nvim",
  keys = {
    {
      "<leader>z",
      "<cmd>ZenMode<CR>",
      mode = "n",
    },
  },
  opts = {
    backdrop = 0.95,
    window = {
      width = 150,
      options = {
        signcolumn = "yes",
      },
    },
  },
}
