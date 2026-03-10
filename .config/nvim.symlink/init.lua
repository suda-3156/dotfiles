require 'core.options'
require 'core.keymaps'
require 'core.snippets'
require 'config.lazy'

-- Automatically load `.session.vim` if exists
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local session = vim.fn.getcwd() .. '/.session.vim'
    if vim.fn.filereadable(session) == 1 then
      vim.cmd('source ' .. vim.fn.fnameescape(session))
    end
  end,
})

vim.keymap.set('n', '<leader>ms', '<cmd>mksession .session.vim<cr>', { desc = '[M]ake [S]session .session.vim' })
