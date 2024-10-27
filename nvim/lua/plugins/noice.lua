return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  otps = {
    -- add here
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      cmdline = {
        -- view = "cmdline",
      },
      -- lsp = {
      --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      --   override = {
      --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      --     ["vim.lsp.util.stylize_markdown"] = true,
      --     ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      --   },
      -- },
      presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      -- views = {
      --   cmdline_popup = {
      --     position = {
      --       row = 5,
      --       col = "50%",
      --     },
      --     size = {
      --       width = 60,
      --       height = "auto",
      --     },
      --     border = {
      --       style = "none",
      --       padding = { 2, 3 },
      --     },
      --     filter_options = {},
      --     win_options = {
      --       winhighlight = {
      --         Nomal = "Normal",
      --         FloatBorader = "DiagnosticInfo"
      --       },
      --     },
      --   },
      --   popupmenu = {
      --     relative = "editor",
      --     position = {
      --       row = 8,
      --       col = "50%",
      --     },
      --     size = {
      --       width = 60,
      --       height = 10,
      --     },
      --     border = {
      --       style = "none",
      --       padding = { 0, 1 },
      --     },
      --     win_options = {
      --       winhighlight = {
      --         Normal = "Normal",
      --         FloatBorder = "DiagnoticInfo"
      --       },
      --     },
      --   },
      -- },
    }
    -- require("notify").setup({
    --   background_colour = "#000000",
    -- })
  end,
}