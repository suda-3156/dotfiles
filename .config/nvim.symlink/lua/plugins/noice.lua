---@type LazyPluginSpec
return {
  "https://github.com/folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "https://github.com/MunifTanjim/nui.nvim",
    {
      "https://github.com/rcarriga/nvim-notify",
      opts = {
        timeout = 3000,
        background_colour = "#000000",

        -- :help notify-render()
        render = "minimal",
      },
    },
  },

  opts = {
    -- https://github.com/folke/noice.nvim/issues/1097
    routes = {
      {
        view = "notify",
        filter = {
          event = "msg_show",
          kind = {
            "shell_out",
            "shell_err",
          },
        },
      },
    },

    presets = {
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
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
  },
}
