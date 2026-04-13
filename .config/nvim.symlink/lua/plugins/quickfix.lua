local p = {}

p[#p + 1] = {
  "kevinhwang91/nvim-bqf", -- Show preview of the codes around keywords
  event = { "BufReadPre", "BufNewFile" },
  ft = "qf",
}

p[#p + 1] = {
  "stevearc/quicker.nvim", -- Allow modifications in the same way as the Oil
  event = { "BufReadPre", "BufNewFile" },
  ft = "qf",
  opts = {},
  config = function()
    require("quicker").setup()
  end,
}

return p
