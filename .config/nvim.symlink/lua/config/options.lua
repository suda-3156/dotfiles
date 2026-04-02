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
vim.opt.cursorline = false

vim.opt.laststatus = 0
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "0"
vim.opt.showtabline = 2
vim.opt.pumheight = 10

vim.opt.termguicolors = true
vim.opt.conceallevel = 0

vim.opt.list = true

vim.opt.fillchars:append({
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldinner = " ",
  foldclose = "",
})
vim.o.foldcolumn = "1"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = ""

vim.opt.listchars = {
  -- eol = "↲",
  -- tab = ">-",
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

vim.opt.guicursor = {
  "n-v-c-sm:block",
  "i-ci-ve:ver25",
  "r-cr-o:hor20",
}

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
vim.opt.inccommand = "split"

-- Edit
vim.opt.clipboard:append("unnamedplus,unnamed")
vim.opt.scrolloff = 10
vim.o.softtabstop = 2
vim.opt.mouse = "a"
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
vim.opt.virtualedit = "block"
vim.opt.backspace = { "indent", "eol", "start", "nostop" }
vim.opt.completeopt = "menuone,noselect"

vim.opt.ambiwidth = "single"
vim.opt.visualbell = false
vim.opt.ttyfast = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.shortmess:append("c")

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
vim.opt.spelllang = { "en", "cjk" }

vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.sessionoptions = {
  "buffers",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions",
}
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
