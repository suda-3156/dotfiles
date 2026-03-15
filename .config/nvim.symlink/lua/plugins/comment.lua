local box = {
  "https://github.com/LudoPinelli/comment-box.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>cb", "<cmd>CBccbox<cr>",   mode = { "n", "x" }, desc = "[C]omment box [T]itle" },
    { "<leader>ct", "<cmd>CBlllline<cr>", mode = { "n", "x" }, desc = "[C]omment box titled [L]ine" },
    { "<leader>cl", "<cmd>CBline<cr>",    mode = "n",          desc = "[C]omment box simple [L]ine" },
    { "<leader>cm", "<cmd>CBllbox14<cr>", mode = { "n", "x" }, desc = "[C]omment box [M]arked comments" },
  },
}

local todo = {
  "https://github.com/folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  ---@module 'todo-comments'
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = { signs = false },
}

return {
  box,
  todo,
}
