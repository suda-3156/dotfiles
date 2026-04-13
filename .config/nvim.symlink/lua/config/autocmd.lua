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
    "gitsigns-blame", -- gitsigns blame view
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

-- From: https://zenn.dev/vim_jp/articles/29d021fff07e60
--       https://github.com/kawarimidoll/dotfiles/blob/master/.config/nvim/lua/mi/prefix_q.lua
local augroup_wrapper = vim.api.nvim_create_augroup("prefix-q-wrapper", {})
vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  group = augroup_wrapper,
  callback = function()
    -- q以外のマクロは使わないので即終了
    if vim.fn.reg_recording() ~= "q" then
      vim.cmd.normal({ args = { "q" }, bang = true })
      return
    end

    local augroup_inner = vim.api.nvim_create_augroup("prefix-q-inner", {})

    local buffer = vim.api.nvim_get_current_buf()
    -- vim.keymap.set('n', 'q', 'q', { nowait = true, buffer = buffer })
    -- HACK: mini.clueがbuffer mappingを上書きしてくるのでautocmd CursorMovedで設定する
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "*",
      once = true,
      group = augroup_inner,
      callback = function()
        vim.keymap.set("n", "q", "q", { nowait = true, buffer = buffer })
      end,
      desc = "set stop-recording key",
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
      pattern = "*",
      once = true,
      group = augroup_inner,
      callback = function()
        vim.cmd.normal({ args = { "q" }, bang = true })
        vim.notify("stop recording", vim.log.levels.INFO)
      end,
      desc = "stop recording when leaving buffer",
    })
    vim.api.nvim_create_autocmd("RecordingLeave", {
      pattern = "*",
      once = true,
      callback = function()
        vim.keymap.del("n", "q", { buffer = buffer })
        vim.api.nvim_del_augroup_by_id(augroup_inner)
      end,
      desc = "delete q mapping when recording leave",
    })
  end,
})
