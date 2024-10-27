return {
  'shellRaining/hlchunk.nvim',
  -- event = { "BufReadPre", "BufNewFile" },
  event = { 'UIEnter' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
        chars = {
          horizontal_line = '─',
          vertical_line = '│',
          left_top = '╭',
          left_bottom = '╰',
          right_arrow = '>',
        },
        style = '#806d9c',
      },
      line_num = {
        enable = true,
        style = '#806d9c',
      },
    }
  end,
}
