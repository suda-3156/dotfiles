return {
  {
    'kevinhwang91/nvim-bqf', -- Show preview of the codes around keywords
    event = { 'BufReadPre', 'BufNewFile' },
    ft = 'qf',
  },
  {
    'stevearc/quicker.nvim', -- Allow modifications in the same way as the Oil
    event = { 'BufReadPre', 'BufNewFile' },
    ft = 'qf',
    opts = {},
    config = function()
      require('quicker').setup()
    end,
  },
}
