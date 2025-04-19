return {
  'Shatur/neovim-ayu',
  config = function()
    require('ayu').setup {
      mirage = true,
      terminal = true,
      overrides = {
        Normal = { bg = 'None' },
        ColorColumn = { bg = 'None' },
        SignColumn = { bg = 'None' },
        Folded = { bg = 'None' },
        FoldColumn = { bg = 'None' },
        CursorLine = { bg = 'None' },
        CursorColumn = { bg = 'None' },
        WhichKeyFloat = { bg = 'None' },
        VertSplit = { bg = 'None' },
      },
    }
    require('lualine').setup {
      options = {
        theme = 'ayu',
      },
    }
    require('ayu').colorscheme()
  end,
}
