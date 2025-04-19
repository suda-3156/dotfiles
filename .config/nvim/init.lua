require 'core.options'
require 'core.keymaps'
-- require 'core.snippets'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup ({
  require 'plugins.neo-tree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.gitsigns',
  require 'plugins.misc',
  require 'plugins.comment',
  require 'plugins.hlchunk',
  -- require 'plugins.lazygit',
  -- require 'plugins.debug',
  require 'plugins.noice',
  require 'plugins.close-buffers',
  -- require 'plugins.nvim-ts-autotag',
  -- require 'plugins.copilot',
  require 'plugins.colorthemes.nord',
  require 'plugins.surround',
  require 'plugins.barbecue',
  -- require 'plugins.diffview',
  require 'plugins.scrollbar',
  require 'plugins.trouble',
  require 'plugins.oil',
  require 'plugins.dashboard',
})

