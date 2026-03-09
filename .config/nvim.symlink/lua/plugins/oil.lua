-- From: https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/plugins/oil.lua
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  config = function(_, opts)
    require('oil').setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      default_file_explorer = true,
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        'icon',
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
      delete_to_trash = true,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
      win_options = {
        wrap = true,
        winhighlight = 'Normal:Normal,NormalNC:NormalNC',
      },
    }

    local function fix_oil_hl()
      for _, group in ipairs { 'OilDir', 'OilDirIcon' } do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl then
          hl.bg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end
    end
    vim.api.nvim_create_autocmd('ColorScheme', { callback = fix_oil_hl })
    fix_oil_hl()

    vim.keymap.set('n', '<M-o>', '<cmd>Oil<CR>', { noremap = true, silent = true })
  end,
}
