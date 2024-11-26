return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    -- Coc拡張の設定
    vim.g.coc_global_extensions = {
      'coc-tsserver',
      'coc-eslint',
      'coc-prettier',
      'coc-git',
      'coc-fzf-preview',
      'coc-lists',
    }

    -- TypeScriptファイルの特定の設定
    vim.cmd([[
      augroup coc_ts
        autocmd!
        autocmd FileType typescript,typescriptreact call v:lua.coc_typescript_settings()
      augroup END
    ]])

    -- Coc-TS設定の関数
    _G.coc_typescript_settings = function()
      vim.api.nvim_buf_set_keymap(0, 'n', '<Plug>(lsp)f', ':CocCommand eslint.executeAutofix<C-R><C-U>:CocCommand prettier.formatFile<CR>', { noremap = true, silent = true })
    end

    -- ドキュメント表示関数
    function _G.show_documentation()
      local filetype = vim.bo.filetype
      if filetype == 'vim' or filetype == 'help' then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
      elseif vim.fn['coc#rpc#ready']() then
        vim.fn['CocActionAsync']('doHover')
      end
    end

    -- ドキュメント表示関数
    vim.api.nvim_set_keymap('n', 'K', "<Cmd>call v:lua.show_documentation()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>rn', "<Plug>(coc-rename)", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leadre>a', "<Plug>(coc-codeaction-cursor)", { noremap = true, silent = true })
    
    -- キー設定
    vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

    -- 次の補完候補を選択
    vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, silent = true })

    -- 前の補完候補を選択
    vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, silent = true })

    -- 補完候補を確定
    vim.api.nvim_set_keymap('i', '<CR>', 'coc#pum#visible() ? coc#_select_confirm() : "\\<CR>"', { noremap = true, silent = true })
  end
}
