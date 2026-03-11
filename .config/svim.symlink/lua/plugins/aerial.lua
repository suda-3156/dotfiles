return {
  "https://github.com/stevearc/aerial.nvim",
  event = "VeryLazy",
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = {
      "treesitter",
      "lsp",
      "markdown",
      "man",
    },
    layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a list of mixed types.
      -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
      max_width = { 80, 0.2 },
      width = nil,
      min_width = 20,

      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = "right",

      -- When the symbols change, resize the aerial window (within min/max constraints) to fit
      resize_to_content = true,
    },

    -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("aerial.actions").<name>
    -- Set to `false` to remove a keymap
    -- keymaps = {
    --   ["?"] = "actions.show_help",
    --   ["g?"] = "actions.show_help",
    --   ["<CR>"] = "actions.jump",
    --   ["<2-LeftMouse>"] = "actions.jump",
    --   ["<C-v>"] = "actions.jump_vsplit",
    --   ["<C-s>"] = "actions.jump_split",
    --   ["p"] = "actions.scroll",
    --   ["<C-j>"] = "actions.down_and_scroll",
    --   ["<C-k>"] = "actions.up_and_scroll",
    --   ["{"] = "actions.prev",
    --   ["}"] = "actions.next",
    --   ["[["] = "actions.prev_up",
    --   ["]]"] = "actions.next_up",
    --   ["q"] = "actions.close",
    --   ["o"] = "actions.tree_toggle",
    --   ["za"] = "actions.tree_toggle",
    --   ["O"] = "actions.tree_toggle_recursive",
    --   ["zA"] = "actions.tree_toggle_recursive",
    --   ["l"] = "actions.tree_open",
    --   ["zo"] = "actions.tree_open",
    --   ["L"] = "actions.tree_open_recursive",
    --   ["zO"] = "actions.tree_open_recursive",
    --   ["h"] = "actions.tree_close",
    --   ["zc"] = "actions.tree_close",
    --   ["H"] = "actions.tree_close_recursive",
    --   ["zC"] = "actions.tree_close_recursive",
    --   ["zr"] = "actions.tree_increase_fold_level",
    --   ["zR"] = "actions.tree_open_all",
    --   ["zm"] = "actions.tree_decrease_fold_level",
    --   ["zM"] = "actions.tree_close_all",
    --   ["zx"] = "actions.tree_sync_folds",
    --   ["zX"] = "actions.tree_sync_folds",
    -- },

    -- Control which windows and buffers aerial should ignore.
    -- Aerial will not open when these are focused, and existing aerial windows will not be updated
    ignore = {
      -- Ignore unlisted buffers. See :help buflisted
      unlisted_buffers = false,

      -- Ignore diff windows (setting to false will allow aerial in diff windows)
      diff_windows = true,

      -- List of filetypes to ignore.
      filetypes = {},

      -- Ignored buftypes.
      -- Can be one of the following:
      -- false or nil - No buftypes are ignored.
      -- "special"    - All buffers other than normal, help and man page buffers are ignored.
      -- table        - A list of buftypes to ignore. See :help buftype for the
      --                possible values.
      -- function     - A function that returns true if the buffer should be
      --                ignored or false if it should not be ignored.
      --                Takes two arguments, `bufnr` and `buftype`.
      buftypes = "special",

      -- Ignored wintypes.
      -- Can be one of the following:
      -- false or nil - No wintypes are ignored.
      -- "special"    - All windows other than normal windows are ignored.
      -- table        - A list of wintypes to ignore. See :help win_gettype() for the
      --                possible values.
      -- function     - A function that returns true if the window should be
      --                ignored or false if it should not be ignored.
      --                Takes two arguments, `winid` and `wintype`.
      wintypes = "special",
    },
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    vim.keymap.set("n", "<space>a", "<cmd>AerialToggle!<CR>")
  end,
}
