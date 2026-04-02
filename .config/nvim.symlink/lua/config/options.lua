-- options.lua
-- :h options
-- :h option-list

-- Refs: https://github.com/monaqa/dotfiles/blob/master/.config/nvim/lua/rc/option.lua
--       https://github.com/okm321/dotfiles/blob/main/nvim/lua/config/base.lua
--       https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/options.lua

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- Hide status line
vim.opt.laststatus = 0

-- Sign column and fold column
vim.opt.signcolumn = "yes"
vim.o.foldcolumn = "1"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = ""
vim.opt.fillchars:append({
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldinner = " ",
  foldclose = "",
})

vim.opt.showtabline = 2 -- Show tab bar even when there is single tab page
vim.opt.termguicolors = true
vim.opt.conceallevel = 0 -- :h 'conceallevel'

-- Make invisible chars visible
vim.opt.list = true
vim.opt.listchars = {
  -- eol = "↲",
  tab = "  ",
  -- space = "c",
  -- multispace = "c",
  -- lead = "c",
  -- leadmultispace = "c",
  trail = "·",
  extends = "❯",
  precedes = "❮",
  -- conceal = "c",
  nbsp = "%",
}

-- Cursors in modes -- :h 'guicursor'
vim.opt.guicursor = {
  "n-v-c-sm:block",
  "i-ci-ve:ver25",
  "r-cr-o:hor20",
}
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- Indent, empty line and break line
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Search and replacement
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true

-- Edit
vim.opt.clipboard:append("unnamedplus,unnamed")
vim.opt.scrolloff = 3
vim.o.softtabstop = 2
vim.opt.mouse = "a"
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
vim.opt.virtualedit = "block"
vim.opt.backspace = { "indent", "eol", "start", "nostop" }

vim.opt.ambiwidth = "single"
vim.opt.visualbell = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- File, sysmtem and backup
vim.opt.fileencoding = "utf-8"
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.history = 10000

vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.sessionoptions = {
  "buffers",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "localoptions",
}
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
