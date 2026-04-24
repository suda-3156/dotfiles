-- Set comma as leader key
-- We will be unable to go back in find / till motion (f, t, F, T).
-- So we can install: flash.nvim, mini.jump, or other similar plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("core.lazy")

require("config.abbr")
require("config.autocmd")
require("config.filetype")
require("config.keymaps")
require("config.lsp")
require("config.options")

require("utils.alarm").setup({ keys = "asdfhjkl;", count = 10, modes = { "n" } })
