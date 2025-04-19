return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  -- event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    -- local colors = require("nord").setup()
    require("scrollbar").setup({
      -- handle = {
      --     color = colors.bg_highlight,
      -- },
      -- marks = {
      --     Search = { color = colors.orange },
      --     Error = { color = colors.error },
      --     Warn = { color = colors.warning },
      --     Info = { color = colors.info },
      --     Hint = { color = colors.hint },
      --     Misc = { color = colors.purple },
      -- }
    })
  end,
}
