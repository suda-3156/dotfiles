-- From: https://zenn.dev/ras96/articles/4d9d9493d29c06
vim.lsp.enable({
  -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
  "gopls",
  "lua_ls",
  "pyright",
})

-- -- From: kickstart.nvim
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
--   callback = function(event)
--     -- NOTE: Remember that Lua is a real programming language, and as such it is possible
--     -- to define small helper and utility functions so you don't have to repeat yourself.
--     --
--     -- In this case, we create a function that lets us more easily define mappings specific
--     -- for LSP related items. It sets the mode, buffer and description for us each time.
--     local map = function(keys, func, desc, mode)
--       mode = mode or "n"
--       vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--     end
--
--     -- Rename the variable under your cursor.
--     --  Most Language Servers support renaming across files, etc.
--     map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
--
--     -- Execute a code action, usually your cursor needs to be on top of an error
--     -- or a suggestion from your LSP for this to activate.
--     map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
--
--     -- WARN: This is not Goto Definition, this is Goto Declaration.
--     --  For example, in C this would take you to the header.
--     map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--
--     -- The following two autocommands are used to highlight references of the
--     -- word under your cursor when your cursor rests there for a little while.
--     --    See `:help CursorHold` for information about when this is executed
--     --
--     -- When you move your cursor, the highlights will be cleared (the second autocommand).
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     if client and client:supports_method("textDocument/documentHighlight", event.buf) then
--       local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
--       vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--         buffer = event.buf,
--         group = highlight_augroup,
--         callback = vim.lsp.buf.document_highlight,
--       })
--
--       vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--         buffer = event.buf,
--         group = highlight_augroup,
--         callback = vim.lsp.buf.clear_references,
--       })
--
--       vim.api.nvim_create_autocmd("LspDetach", {
--         group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
--         callback = function(event2)
--           vim.lsp.buf.clear_references()
--           vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
--         end,
--       })
--     end
--
--     -- The following code creates a keymap to toggle inlay hints in your
--     -- code, if the language server you are using supports them
--     --
--     -- This may be unwanted, since they displace some of your code
--     if client and client:supports_method("textDocument/inlayHint", event.buf) then
--       map("<leader>th", function()
--         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
--       end, "[T]oggle Inlay [H]ints")
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf
    local navic = require("nvim-navic")

    -- デフォルトで設定されている言語サーバー用キーバインドに設定を追加する
    -- See https://neovim.io/doc/user/lsp.html#lsp-defaults
    -- 言語サーバーのクライアントがLSPで定められた機能を実装していたら設定を追加するという流れ

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<leader>k", function()
        vim.lsp.buf.hover({ border = "single" })
      end, { buffer = buf, desc = "Show hover documentation" })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/documentSymbol") then
      navic.attach(client, buf)
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if
        not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { bufnr = buf })
      -- vim.keymap.set("i", "<Tab>", function()
      --   if not vim.lsp.inline_completion.get() then
      --     return "<Tab>"
      --   end
      --   -- close the completion popup if it's open
      --   if vim.fn.pumvisible() == 1 then
      --     return "<C-e>"
      --   end
      -- end, {
      --   expr = true,
      --   buffer = buf,
      --   desc = "Accept the current inline completion",
      -- })
    end
  end,
})
