return {
  "https://github.com/folke/zen-mode.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", mode = { "n" }, desc = "Toggle Zen mode" },
  },
  opts = {
    window = {
      width = 120, -- width of the Zen window
      height = 1, -- height of the Zen window
    },
    plugins = {
      gitsigns = { enabled = true },
      todo = { enabled = true },
    },
    on_open = function(win)
      vim.opt.fillchars:append({
        eob = " ",
        fold = " ",
        foldopen = "",
        foldsep = " ",
        foldinner = " ",
        foldclose = "",
      })
    end,
  },
}
