-- Close some files with 'q'
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",       -- quickfix-window
    "help",     -- help
    "man",      -- manpage
    "notify",   -- notification
    "nofile",   -- scratch buffer
    "terminal", -- terminal buffer
    "prompt",   -- prompt-buffer
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
  end,
})
