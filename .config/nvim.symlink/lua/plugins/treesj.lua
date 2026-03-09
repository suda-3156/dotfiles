return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  keys = {
    { '<space>tt', '<cmd>TSJToggle<cr>', desc = '[T]reeSJ [T]oggle' },
    { '<space>tj', '<cmd>TSJJoin<cr>', desc = '[T]reeSJ [J]oin' },
    { '<space>ts', '<cmd>TSJSplit<cr>', desc = '[T]reeSJ [S]plit' },
  },
}
