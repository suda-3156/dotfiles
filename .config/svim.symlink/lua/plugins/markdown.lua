-- From: https://eiji.page/blog/neovim-render-markdown-nvim/
return {
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "[T]oggle [M]arkdown view" } },
  },
  opts = {
    heading = {
      width = "block",
      left_pad = 0,
      right_pad = 4,
      icons = {},
    },
    checkbox = {
      checked = { scope_highlight = "@markup.strikethrough" },
      custom = {
        todo = { raw = "", rendered = "", highlight = "" },
        canceled = {
          raw = "[-]",
          rendered = "󱘹",
          scope_highlight = "@markup.strikethrough",
        },
      },
    },
  },
}
