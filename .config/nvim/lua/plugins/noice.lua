return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  otps = {},

  dependencies = {
  "MunifTanjim/nui.nvim",
    {
      'rcarriga/nvim-notify',
      opts = {
        timeout = 2000,
      },
    },
  },

  config = function()
    require("noice").setup({
      -- you can enable a preset for easier configuration
      presets = {
        -- bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        -- lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      -- To lower the cmdline, use custom config below addtionaly to the command_palette preset
      views = {
        cmdline_popup = {
          position = {
            row = 15,
            col = "50%",
          },
        },
      },
    })

    require('notify').setup {
      background_colour = '#000000',
    }
  end,
}
