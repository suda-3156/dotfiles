require 'core.options'
require 'core.keymaps'
require 'core.snippets'

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'nord'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  ayu = 'plugins.colorthemes.ayu',
  catppuccin = 'plugins.colorthemes.catppuccin',
  gruvbox = 'plugins.colorthemes.gruvbox',
  kanagawa = 'plugins.colorthemes.kanagawa',
  nord = 'plugins.colorthemes.nord',
  onedark = 'plugins.colorthemes.onedark',
  zenbone = 'plugins.colorthemes.zenbone',
}

require('lazy').setup {
  require(themes[env_var_nvim_theme]),
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.barbecue',
  require 'plugins.bgf',
  require 'plugins.bufferline',
  require 'plugins.close-buffers',
  require 'plugins.comment',
  require 'plugins.conform',
  require 'plugins.dashboard',
  require 'plugins.dial',
  require 'plugins.diffview',
  require 'plugins.gitsigns',
  require 'plugins.hlchunk',
  require 'plugins.lualine',
  require 'plugins.misc',
  require 'plugins.neo-tree',
  require 'plugins.noice',
  require 'plugins.oil',
  require 'plugins.scrollbar',
  require 'plugins.surround',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.trouble',
}

-- Function to check if a file exists
local function file_exists(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- Path to the session file
local session_file = '.session.vim'

-- Check if the session file exists in the current directory
if file_exists(session_file) then
  -- Source the session file
  vim.cmd('source ' .. session_file)
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
