return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {}, -- require('nvim-treesitter').setup()
    config = function()
      require('nvim-treesitter').install {
        'lua',
        'python',
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'regex',
        'terraform',
        'sql',
        'dockerfile',
        'toml',
        'json',
        'java',
        'go',
        'gitignore',
        'graphql',
        'yaml',
        'make',
        'cmake',
        'markdown',
        'markdown_inline',
        'bash',
        'tsx',
        'css',
        'html',
      }

      -- Highlighting
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '<filetype>' },
        callback = function()
          vim.treesitter.start()
        end,
      })

      -- Register additional file extensions
      vim.filetype.add { extension = { tf = 'terraform' } }
      vim.filetype.add { extension = { tfvars = 'terraform' } }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
        },
        include_surrounding_whitespace = false,
      },
    },
    keys = {
      {
        'am',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select outer function',
      },
      {
        'im',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select inner function',
      },
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select outer class',
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select inner class',
      },
      {
        'as',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
        end,
        mode = { 'x', 'o' },
        desc = 'Select scope',
      },
    },
  },
  {
    'andymass/vim-matchup',
    init = function()
      -- modify your configuration vars here
      vim.g.matchup_treesitter_stopline = 500

      -- or call the setup function provided as a helper. It defines the
      -- configuration vars for you
      require('match-up').setup {
        treesitter = {
          stopline = 500,
        },
      }
    end,
    -- or use the `opts` mechanism built into `lazy.nvim`. It calls
    -- `require('match-up').setup` under the hood
    ---@type matchup.Config
    opts = {
      treesitter = {
        stopline = 500,
      },
    },
  },
}
