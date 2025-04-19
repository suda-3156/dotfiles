return {
  'kazhala/close-buffers.nvim',
  keys = {
    '<leader>to', '<leader>tt', '<leader>ta'
  },
  config = function()
    require('close_buffers').setup {
      preserve_window_layout = { 'this' },
      next_buffer_cmd = function(windows)
        require('bufferline').cycle(1)
        local bufnr = vim.api.nvim_get_current_buf()

        for _, window in ipairs(windows) do
          vim.api.nvim_win_set_buf(window, bufnr)
        end
      end,
    }

    local opts = { noremap = true, silent = true, desc = 'Go to Buffer' }

    vim.api.nvim_set_keymap('n', '<leader>to', [[<CMD>lua require('close_buffers').delete({type = 'other'})<CR>]], opts)
    vim.api.nvim_set_keymap('n', '<leader>tt', [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]], opts)
    vim.api.nvim_set_keymap('n', '<leader>ta', [[<CMD>lua require('close_buffers').delete({type = 'all'})<CR>]], opts)
    -- 現在のタブを削除と，新しいタブはkeymap.luaのbuffets or tabsにある
  end,
}
