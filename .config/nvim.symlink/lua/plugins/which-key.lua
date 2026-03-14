---@type LazyPluginSpec
return {
  "https://github.com/folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 1000,
  },
  keys = {
    {
      "<leader>wk",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show [W]hich [K]ey",
    },
  },
}
