-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- tmux & split window navigation
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy'
  },
  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    lazy = true,
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
    lazy = true,
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
    lazy = true,
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      win = {
        border = {
          { '┌', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '┐', 'FloatBorder' },
          { '│', 'FloatBorder' },
          { '┘', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '└', 'FloatBorder' },
          { '│', 'FloatBorder' },
        },
      },
    },
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
}
