return {
  ---@type LazyPluginSpec
  "https://github.com/shellRaining/hlchunk.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
    },
    indent = {
      enable = true,
      chars = {
        "│",
        "¦",
        "┆",
        "┊",
      },
      style = {
        vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
      },
    },
  },
}
