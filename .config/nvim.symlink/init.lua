require 'core.options'
require 'core.keymaps'
require 'core.snippets'
require 'config.lazy'

-- Automatically load `.session.vim` if exists
-- Deferred to allow plugins (treesitter, etc.) to initialize first,
-- then re-detect filetypes on all buffers to restore syntax highlighting.
local timeout = 100
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local session = vim.fn.getcwd() .. '/.session.vim'
    if vim.fn.filereadable(session) == 0 then
      return
    end
    vim.defer_fn(function()
      vim.cmd('source ' .. vim.fn.fnameescape(session))
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd 'filetype detect'
          end)
        end
      end
      vim.notify('Session loaded: .session.vim', vim.log.levels.INFO)
    end, timeout)
  end,
})

-- Save session with <leader>ms
vim.keymap.set('n', '<leader>ms', function()
  vim.cmd 'mksession! .session.vim'
  vim.notify('Session saved: .session.vim', vim.log.levels.INFO)
end, { desc = '[M]ake [S]ession .session.vim' })
