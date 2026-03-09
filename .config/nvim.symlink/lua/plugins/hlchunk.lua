return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    chunk = {
      enable = true,
    },
  },
}
