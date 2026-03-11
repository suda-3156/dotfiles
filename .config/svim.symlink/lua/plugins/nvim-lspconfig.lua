---@type LazyPluginSpec
return {
  "https://github.com/neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}
