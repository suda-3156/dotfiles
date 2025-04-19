return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavor = 'macchiato',
      transparent_background = true,
      show_end_of_buffer = false,
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    }
    require('lualine').setup {
      options = {
        theme = 'catppuccin',
        -- ... the rest of your lualine config
      },
    }
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end,
}
