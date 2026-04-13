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
    {
      -- Alternative: "https://github.com/mfussenegger/nvim-treehopper"
      "m",
      mode = { "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
  config = function()
    -- FlashBackdrop     Comment      backdrop
    -- FlashMatch        Search       search matches
    -- FlashCurrent      IncSearch    current match
    -- FlashLabel        Substitute   jump label
    -- FlashPrompt       MsgArea      prompt
    -- FlashPromptIcon   Special      prompt icon
    -- FlashCursor       Cursor       cursor

    vim.api.nvim_set_hl(0, "FlashLabel", { underline = true, bold = false, fg = "Orange", ctermfg = "Red" })
    vim.api.nvim_set_hl(0, "FlashMatch", { underline = false, bold = true, fg = "Orange", ctermfg = "Red" })
    vim.api.nvim_set_hl(0, "FlashLabel", { underline = true, bold = false, fg = "Orange", ctermfg = "Red" })
    vim.api.nvim_set_hl(
      0,
      "FlashCurrent",
      { bold = true, fg = "Black", bg = "Orange", ctermfg = "Black", ctermbg = "Red" }
    )

    require("flash").setup({
      labels = "asdfghjklqwertyuiopzxcvbnm",
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
