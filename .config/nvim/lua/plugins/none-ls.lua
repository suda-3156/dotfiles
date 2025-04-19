-- Format on save and linters
return {
  'nvimtools/none-ls.nvim',
  event = 'InsertEnter',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    -- list of formatters & linters for mason to install
    require('mason-null-ls').setup({
      ensure_installed = {
        -- 'checkmake',
        'prettier', -- ts/js formatter
        -- 'stylua',   -- lua formatter
        'eslint_d', -- ts/js linter
        'shfmt',
        'ruff',
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    })

    local sources = {
      -- diagnostics.checkmake,
      formatting.prettierd.with({ filetypes = { 'html', 'json', 'yaml', 'markdown'}}),
      formatting.shfmt.with { args = { '-i', '4' } },
      -- formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    null_ls.setup()
    null_ls.register({
      diagnostics_format= "#{m} (#{s}: #{c})",
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })


    -- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    --   pattern = { '*' },
    --   callback = function()
    --     require('lspsaga.diagnostic').show_cursor_diagnostics()
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd({ 'FileType' }, {
    --   pattern = { 'typescript', 'typescriptreact', 'typescript.tsx' },
    --   callback = function()
    --     vim.keymap.set({ 'n' }, '<leader>lf', function()
    --       vim.cmd([[EslintFixAll]])
    --       vim.lsp.buf.format({ name = 'null-ls' })
    --     end)
    --   end,
    -- })

    -- local function show_documentation()
    --   local ft = vim.opt.filetype._value
    --   if ft == 'vim' or ft == 'help' then
    --     vim.cmd([[execute 'h ' . expand('<cword>') ]])
    --   else
    --     require('lspsaga.hover').render_hover_doc()
    --   end
    -- end
    --
    -- vim.keymap.set({ 'n' }, 'K', show_documentation)
  end,
}
