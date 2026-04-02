return {
  "https://github.com/folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    {
      "`",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "FlashLabel", { underline = true, bold = true, fg = "Orange", ctermfg = "Red" })
    vim.api.nvim_set_hl(
      0,
      "FlashCurrent",
      { bold = true, fg = "Black", bg = "Orange", ctermfg = "Black", ctermbg = "Red" }
    )

    require("flash").setup({
      labels = "asdfghjklqwertyuiopvnm",
      label = {
        reuse = "all",
      },
      modes = {
        char = {
          -- Alter ',' to '~' since using ',' as the leader key
          keys = { "f", "F", "t", "T", ";", [","] = "~" },
        },
      },
    })
  end,
}
