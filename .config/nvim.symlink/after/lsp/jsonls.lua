--Ref: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jsonls.lua
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('jsonls', {
  capabilities = capabilities,
})

return {}
