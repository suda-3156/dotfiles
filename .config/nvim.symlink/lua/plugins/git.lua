local p = {}

p[#p + 1] = {
  "https://github.com/tpope/vim-fugitive",
  event = { "BufReadPost", "BufNewFile" },
}

p[#p + 1] = {
  -- GitHub integration for vim-fugitive
  "https://github.com/tpope/vim-rhubarb",
  event = { "BufReadPost", "BufNewFile" },
}

p[#p + 1] = {
  "https://github.com/lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    current_line_blame = true,
  },
  keys = {
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk()
      end,
      mode = { "n" },
      desc = "Git Stage hunk",
    },
    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk()
      end,
      mode = { "n", "x" },
      desc = "Git Reset hunk",
    },
    {
      "<leader>gb",
      function()
        require("gitsigns").blame()
      end,
      mode = { "n" },
      desc = "Git Blame",
    },
    {
      "<leader>tb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      mode = { "n" },
      desc = "Toggle current line Blame",
    },
    {
      mode = { "n" },
      "<leader>gS",
      function()
        require("gitsigns").stage_buffer()
      end,
      desc = "Git Stage buffer",
    },
    {
      mode = { "n" },
      "<leader>gR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Git Reset buffer",
    },
    {
      mode = { "n" },
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Git Preview hunk",
    },
    {
      mode = { "n" },
      "<leader>gi",
      function()
        require("gitsigns").preview_hunk_inline()
      end,
      desc = "Git preview hunk Inline",
    },
    {
      mode = { "n" },
      "<leader>gtb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Git Toggle line blame",
    },
    {
      mode = { "n" },
      "<leader>gtw",
      function()
        require("gitsigns").toggle_word_diff()
      end,
      desc = "Git Toggle Word diff",
    },
    {
      mode = { "o", "x" },
      "ih",
      function()
        require("gitsigns").select_hunk()
      end,
    },
    {
      "<leader>gq",
      function()
        require("gitsigns").setqflist("all")
      end,
      mode = { "n" },
      desc = "Set qflist to unstaged changes",
    },
  },
}

p[#p + 1] = {
  "https://github.com/sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", mode = { "n" }, desc = "Git Diff" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", mode = { "n" }, desc = "Git current File history" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", mode = { "n" }, desc = "Git branch History" },
  },
  config = function()
    local close = { "n", "qc", "<cmd>tabclose<cr>", { desc = "Exit Diffview" } }
    require("diffview").setup({
      keymaps = {
        view = { close },
        file_panel = { close },
        file_history_panel = { close },
      },
    })
  end,
}

return p
