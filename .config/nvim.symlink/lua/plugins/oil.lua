return {
  { -- Use oil.nvim as the main filer, and fyler.nvim to understand directory structure.
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function()
      require('oil').setup {
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,

        keymaps = {
          ['g?'] = { 'actions.show_help', mode = 'n' },
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = false, -- { 'actions.select', opts = { vertical = true } },
          ['<C-h>'] = false, -- { 'actions.select', opts = { horizontal = true } },
          ['<C-t>'] = false, -- { 'actions.select', opts = { tab = true } },
          ['<C-p>'] = 'actions.preview',
          ['q'] = { 'actions.close', mode = 'n' },
          ['<C-c>'] = { 'actions.close', mode = 'n' },
          ['<C-l>'] = 'actions.refresh',
          ['-'] = { 'actions.parent', mode = 'n' },
          ['_'] = { 'actions.open_cwd', mode = 'n' },
          ['`'] = { 'actions.cd', mode = 'n' },
          ['g~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
          ['gs'] = { 'actions.change_sort', mode = 'n' },
          ['gx'] = 'actions.open_external',
          ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
          ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        },
        -- set to false to disable all of the above keymaps
        use_default_keymaps = false,

        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == '.git' or name == '.jj'
          end,
        },
        win_options = {
          signcolumn = 'yes:2', -- oil-git-status.nvim requires this config
        },

        -- Configuration for the floating window in oil.open_float
        float = {
          padding = 6,
          max_width = 0.8,
          max_height = 0.8,
          border = 'rounded',
          get_win_title = nil,
          preview_split = 'auto',
        },
      }

      -- for background transparency
      local function fix_oil_hl()
        -- TODO: Setting NormalFloat to transparent affects to all the floating window; consider another way ot split files
        for _, group in ipairs { 'OilDir', 'OilDirIcon', 'NormalFloat', 'FloatBorder' } do
          -- for _, group in ipairs { 'OilDir', 'OilDirIcon' } do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
          if ok and hl then
            hl.bg = nil
            vim.api.nvim_set_hl(0, group, hl)
          end
        end
      end
      vim.api.nvim_create_autocmd('ColorScheme', { callback = fix_oil_hl })
      fix_oil_hl()

      -- Open files using relative path
      -- From: https://github.com/stevearc/oil.nvim/issues/234
      vim.api.nvim_create_augroup('OilRelPathFix', {})
      vim.api.nvim_create_autocmd('BufLeave', {
        group = 'OilRelPathFix',
        pattern = 'oil:///*',
        callback = function()
          vim.cmd 'cd .'
        end,
      })

      vim.keymap.set('n', '<M-o>', '<cmd>Oil --float<CR>', { noremap = true, silent = true })
    end,
  },
  { -- Show git status in oil directory listings
    'refractalize/oil-git-status.nvim',
    dependencies = {
      'stevearc/oil.nvim',
    },
    opts = {},
  },
}
