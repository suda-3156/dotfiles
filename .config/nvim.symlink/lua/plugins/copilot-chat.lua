return {
  'CopilotC-Nvim/CopilotChat.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    debug = false,
    model = 'claude-sonnet-4.5',
    language = 'Japanese',

    window = {
      layout = 'vertical',
      width = 0.3,
    },

    headers = {
      user = ' ',
      assistant = ' ',
      tool = ' ',
    },
  },

  keys = {
    {
      '<leader>cc',
      function()
        require('CopilotChat').toggle()
      end,
      desc = 'CopilotChat - Toggle',
    },
    {
      '<leader>cr',
      function()
        require('CopilotChat').reset()
      end,
      desc = 'CopilotChat - Reset',
    },
    {
      '<leader>cs',
      function()
        require('CopilotChat').stop()
      end,
      desc = 'CopilotChat - Stop',
    },
  },
}
