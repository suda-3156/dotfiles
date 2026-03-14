-- keymaps.lua
-- :h keymaps -- overview of keymap settings
-- :h map-modes -- modes which set to the first arg

local myp = require("suda-3156")

-- Set comma as leader key
-- We will be unable to go back in find / till motion (f, t, F, T).
-- So we can install: flash.nvim, mini.jump, or other similar plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Search and wrapped line navigation
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up by display line when no count" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down by display line when no count" })

-- Editing helpers
vim.keymap.set("n", "p", "p`]", { desc = "Paste and move to pasted end" })
vim.keymap.set("n", "P", "P`]", { desc = "Paste before and move to pasted end" })
vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = "Delete with black hole register" })
vim.keymap.set("n", "X", '"_D', { desc = "Delete to end with black hole register" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "<C-c>", "ciw", { desc = "Change inner word" })
vim.keymap.set("x", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right and keep selection" })
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without overwriting unnamed register" })
vim.keymap.set("n", "U", "<c-r>", { desc = "Redo" })

-- Scrolling and search centering
vim.keymap.set("n", "<C-d>", "<c-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<c-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center cursor" })

-- VSCode-like editing motions
vim.keymap.set("n", "<A-z>", "<cmd>set wrap!<cr>", { desc = "Toggle line wrap" })
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move current line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move current line up" })
vim.keymap.set("x", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("n", "<A-S-k>", "VyP", { desc = "Duplicate line above" })
vim.keymap.set("x", "<A-S-k>", "yP`[V`]o", { desc = "Duplicate selection above" })
vim.keymap.set("n", "<A-S-j>", "Vyp", { desc = "Duplicate line below" })
vim.keymap.set("x", "<A-S-j>", "y'>p`[v`]o", { desc = "Duplicate selection below" })

-- Emacs-like insert mode navigation
vim.keymap.set("i", "<C-a>", "<home>", { desc = "Move to line start" })
vim.keymap.set("i", "<C-e>", "<end>", { desc = "Move to line end" })
vim.keymap.set("i", "<C-b>", "<left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-f>", "<right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<M-b>", "<c-left>", { desc = "Move one word left" })
vim.keymap.set("i", "<M-f>", "<c-right>", { desc = "Move one word right" })
vim.keymap.set("i", "<C-d>", "<del>", { desc = "Delete character under cursor" })

-- Window management
vim.keymap.set("n", "<leader>\\", "<c-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>-", "<c-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>ew", "<c-w>=", { desc = "[E]qualize [W]indow sizes" })
vim.keymap.set("n", "<leader>cw", ":close<cr>", { desc = "[C]lose current [W]indow" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Go to left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Go to right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Go to upper window" })

-- Window resizing
local window = myp.window
vim.keymap.set("n", "<Up>", function()
  window.resize(0, "up", 2)
end, { desc = "Resize window upward" })
vim.keymap.set("n", "<Down>", function()
  window.resize(0, "down", 2)
end, { desc = "Resize window downward" })
vim.keymap.set("n", "<Right>", function()
  window.resize(0, "right", 4)
end, { desc = "Resize window to the right" })
vim.keymap.set("n", "<Left>", function()
  window.resize(0, "left", 4)
end, { desc = "Resize window to the left" })
