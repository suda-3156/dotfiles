return {
  'kevinhwang91/nvim-ufo',
  event = 'BufRead',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    -- Show states of lines; expandable, foldable, or deps maybe
    -- vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99 -- Expand all in initial state
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    -- "foldinner" is not supported with my nvim version, so hide foldcolumn above
    -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:]]
    vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'neo-tree' },
      callback = function()
        require('ufo').detach()
        vim.opt_local.foldenable = false
      end,
    })

    require('ufo').setup {
      provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
      end,
    }
  end,
}
