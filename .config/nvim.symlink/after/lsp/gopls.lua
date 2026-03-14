-- From: https://github.com/izumin5210/dotfiles/blob/main/config/.config/nvim/after/lsp/gopls.lua
---@type vim.lsp.Config
local config = {
  settings = {
    gopls = {
      gofumpt = true,
      semanticTokens = true,
      usePlaceholders = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

return config
