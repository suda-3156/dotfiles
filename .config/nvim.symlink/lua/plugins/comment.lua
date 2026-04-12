local p = {}

p[#p + 1] = {
  "https://github.com/LudoPinelli/comment-box.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>cb", "<cmd>CBccbox<cr>", mode = { "n", "x" }, desc = "Comment box Title" },
    { "<leader>ct", "<cmd>CBlllline<cr>", mode = { "n", "x" }, desc = "Comment box titled Line" },
    { "<leader>cl", "<cmd>CBline<cr>", mode = "n", desc = "Comment box simple Line" },
    { "<leader>cm", "<cmd>CBllbox14<cr>", mode = { "n", "x" }, desc = "Comment box Marked comments" },
  },
}

p[#p + 1] = {
  "https://github.com/folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  ---@module 'todo-comments'
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = { signs = false },
}

return p
