return {
  'mvllow/modes.nvim',
  event = { 'CursorMoved', 'CursorMovedI' },
  version = '*',
  config = function()
    local palette = require('monokai-pro').get_palette 'octagon'
    require('modes').setup {
      colors = {
        copy = palette.accent3, -- yellow
        delete = palette.accent1, -- red/pink
        insert = palette.accent5, -- cyan
        visual = palette.accent6, -- purple
        -- change = palette.accent1, -- red/pink
        -- format = palette.accent2, -- orange
        -- replace = palette.dimmed4,
        -- select = palette.accent6, -- purple
      },
      line_opacity = {
        copy = 0.4,
        delete = 0.4,
        insert = 0.5,
        visual = 0.4,
        -- change = 0.4,
        -- format = 0.4,
        -- replace = 0.4,
        -- select = 0.4,
      },
    }
  end,
}
