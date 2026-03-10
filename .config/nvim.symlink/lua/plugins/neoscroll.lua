return {
  'karb94/neoscroll.nvim',
  event = 'BufReadPost',
  opts = {
    stop_eof = false, -- If set true, stop at <EOF> when scrolling downwards
    -- Keys to be mapped to their corresponding default scrolling animation
    -- mappings = {
    --   '<C-u>',
    --   '<C-d>',
    --   '<C-b>',
    --   '<C-f>',
    --   '<C-y>',
    --   '<C-e>',
    --   'zt',
    --   'zz',
    --   'zb',
    -- },
  },
}
