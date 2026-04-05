-- Close some files with 'q'
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf", -- quickfix-window
    "help", -- help
    "man", -- manpage
    "notify", -- notification
    "nofile", -- scratch buffer
    "terminal", -- terminal buffer
    "prompt", -- prompt-buffer
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    local bufnr = event.buf
    if vim.bo[bufnr].buftype == "help" then
      vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
    end
  end,
})
