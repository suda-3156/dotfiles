local p = {}

p[#p + 1] = {
  "kevinhwang91/nvim-bqf", -- Show preview of the codes around keywords
  ft = "qf",
}

p[#p + 1] = {
  "stevearc/quicker.nvim", -- Allow modifications in the same way as the Oil
  ft = "qf",
  opts = {},
}

return p
