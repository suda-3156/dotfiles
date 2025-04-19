return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  otps = {
    -- add here
  },
  -- opts = function(_, otps)
  --   table.insert(otps.routes, {
  --     filter = {
  --       event = 'notify',
  --       find = 'No informaiton available',
  --     },
  --     opts = { skip = true },
  --   })
  --   opts.presets.lsp_doc_border = true
  -- end,

  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        timeout = 2000,
      },
    },
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
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
    require('notify').setup {
      background_colour = '#000000',
    }
  end,
}
