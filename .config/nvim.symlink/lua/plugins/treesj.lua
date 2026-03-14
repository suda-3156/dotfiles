---@type LazyPluginSpec
return {
  "https://github.com/Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
  keys = {
    { "<leader>tt", "<cmd>TSJToggle<cr>", desc = "[T]reeSJ [T]oggle" },
    { "<leader>tj", "<cmd>TSJJoin<cr>", desc = "[T]reeSJ [J]oin" },
    { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "[T]reeSJ [S]plit" },
  },
}
