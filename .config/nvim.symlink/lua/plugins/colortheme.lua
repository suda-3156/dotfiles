local OneDark = {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'dark',
      transparent = true,
      term_colors = true,
      ending_tildes = true,

      -- lualine = {
      --   transparent = false,
      -- },
    }
    require('onedark').load()
  end,
}

local Monokai = {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('monokai-pro').setup {
      transparent_background = true,
      terminal_colors = true,
      devicons = true,
      filter = 'octagon',
      inc_search = 'background',
    }
    vim.cmd.colorscheme 'monokai-pro'
    vim.opt.fillchars = { eob = ' ' }
  end,
}

return Monokai
