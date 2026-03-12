-- From: https://github.com/izumin5210/dotfiles/blob/main/config/.config/nvim/after/lsp/graphql.lua
---@type vim.lsp.Config
local config = {
  filetypes = vim.list_extend(
    require("lspconfig.configs.graphql").default_config.filetypes,
    { "typescript", "javascript" }
  ),
}

return config
