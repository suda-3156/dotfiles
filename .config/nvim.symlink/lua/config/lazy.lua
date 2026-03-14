-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local spec = {
  { import = "plugins.aerial" },
  { import = "plugins.auto-session" },
  { import = "plugins.autopairs" },
  { import = "plugins.blink-cmp" },
  { import = "plugins.buffer" },
  { import = "plugins.colortheme" },
  { import = "plugins.comment" },
  { import = "plugins.conform" },
  { import = "plugins.dashboard" },
  { import = "plugins.denops" },
  { import = "plugins.diagnostic" },
  { import = "plugins.dial" },
  { import = "plugins.filetype" },
  { import = "plugins.flash" },
  { import = "plugins.fyler" },
  { import = "plugins.git" },
  { import = "plugins.hlchunk" },
  { import = "plugins.incline" },
  { import = "plugins.markdown" },
  { import = "plugins.modes" },
  { import = "plugins.neoscroll" },
  { import = "plugins.noice" },
  { import = "plugins.nvim-lspconfig" },
  { import = "plugins.oil" },
  -- { import = "plugins.snacks" },
  { import = "plugins.surround" },
  { import = "plugins.telescope" },
  { import = "plugins.tmux" },
  { import = "plugins.toggleterm" },
  { import = "plugins.treesitter" },
  { import = "plugins.treesj" },
  { import = "plugins.trouble" },
  { import = "plugins.ufo" },
  { import = "plugins.which-key" },
  { import = "plugins.zen-mode" },
}

require("lazy").setup({
  spec = spec,
  defaults = { lazy = true },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      -- TODO: disable plugins
      -- disabled_plugins = {
      --   "gzip",
      --   "matchit",
      --   "matchparen",
      --   "netrwPlugin",
      --   "rplugin",
      --   "tarPlugin",
      --   "tohtml",
      --   "tutor",
      --   "zipPlugin",
      -- },
    },
  },
})
