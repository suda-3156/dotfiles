return {
  'romgrk/barbar.nvim',
  lazy = false,
  -- event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    { '<leader>ba', '<Cmd>BufferCloseAllButCurrent<CR>', desc = 'Delete All Buffers except for Current' },
    { '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>', desc = 'Delete Buffers to the Right' },
    { '<leader>bl', '<Cmd>BufferCloseBuffersLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<S-h>', '<cmd>BufferPrevious<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferNext<cr>', desc = 'Next Buffer' },
    { '<leader>bc', '<cmd>BufferClose<cr>', desc = 'Close Buffer' },
  },

  config = function()
    require('barbar').setup {
      auto_hide = 0,
    }

    -- transparent tab line
    local function fix_tabfill()
      vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'NONE' })
    end
    vim.api.nvim_create_autocmd('ColorScheme', { callback = fix_tabfill })
    fix_tabfill()
  end,
}
