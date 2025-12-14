-- LSP Diagnostic Settings

local M = {}

-- Diagnostic display settings
function M.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      float = true,
    }
  )
  vim.diagnostic.config({ severity_sort = true })

  -- Show diagnostics in a floating window on CursorHold
  local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
  vim.opt.updatetime = 500
  vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = diagnostic_hover_augroup_name,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "FocusLost", "InsertEnter" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

return M
