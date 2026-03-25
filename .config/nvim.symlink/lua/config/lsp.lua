-- From: https://zenn.dev/ras96/articles/4d9d9493d29c06
--       kickstart.nvim
vim.lsp.enable({
  -- Go
  "gopls",

  -- JavaScript
  "biome",
  "denols",
  "tailwindcss",
  "vtsls",

  -- Python
  "pyright",

  -- JSON (JSON Schema)
  "jsonls",
  "jsonnet_ls",
  "tombi", -- toml
  "yamlls",

  -- Lua
  "lua_ls",
})

-- :h lsp-defaults
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf
    local navic = require("nvim-navic")

    -- unset_defaults(args)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "[G]oto [d]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "[G]oto [D]eclaration" })
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = buf, desc = "[R]e[N]ame" })
    vim.keymap.set({ "n", "x" }, "gA", vim.lsp.buf.code_action, { buffer = buf, desc = "[G]oto Code [A]ction" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = buf, desc = "[G]oto [I]mplementation" })

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(e)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method("textDocument/inlayHint", args.buf) then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
      end, { desc = "[T]oggle Inlay [H]ints" })
    end

    navic.attach(client, buf)
  end,
})
