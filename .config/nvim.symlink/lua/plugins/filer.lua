local p = {}

-- Oil (Main filer)
p[#p + 1] = {
  "https://github.com/stevearc/oil.nvim",
  dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup({
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,

      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = false, -- { 'actions.select', opts = { horizontal = true } },
        ["<C-t>"] = false, -- { 'actions.select', opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["~"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      -- set to false to disable all of the above keymaps
      use_default_keymaps = false,

      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git" or name == ".jj"
        end,
      },
      win_options = {
        signcolumn = "yes:2", -- oil-git-status.nvim requires this config
      },

      -- Configuration for the floating window in oil.open_float
      float = {
        padding = 6,
        max_width = 0.8,
        max_height = 0.8,
        border = "rounded",
        get_win_title = nil,
        preview_split = "auto",
      },
    })

    -- for background transparency
    local function fix_oil_hl()
      for _, group in ipairs({ "OilDir", "OilDirIcon" }) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl then
          hl.bg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_oil_hl })
    fix_oil_hl()

    -- Open files using relative path
    -- From: https://github.com/stevearc/oil.nvim/issues/234
    vim.api.nvim_create_augroup("OilRelPathFix", {})
    vim.api.nvim_create_autocmd("BufLeave", {
      group = "OilRelPathFix",
      pattern = "oil:///*",
      callback = function()
        vim.cmd("cd .")
      end,
    })

    local function is_oil_buffer(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return false
      end

      if vim.bo[bufnr].filetype == "oil" then
        return true
      end

      local name = vim.api.nvim_buf_get_name(bufnr)
      return name:match("^oil://") ~= nil
    end

    local function find_oil_window()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
          local bufnr = vim.api.nvim_win_get_buf(win)
          if is_oil_buffer(bufnr) then
            return win
          end
        end
      end
      return nil
    end

    -- open oil floating window once (open_float create new window even when the current buffer is oil)
    ---@param path? string
    local function open_once(path)
      local oil_win = find_oil_window()
      if oil_win then
        vim.api.nvim_set_current_win(oil_win)
        return
      end

      require("oil").open_float(path)
    end

    vim.keymap.set("n", "<M-o>", function()
      open_once()
    end, { desc = "Open Oil in current buffer's directory" })

    vim.keymap.set("n", "<leader>oo", function()
      open_once(".")
    end, { desc = "[O]pen [O]il in current directory" })
  end,
}

p[#p + 1] = { -- Show git status in oil directory listings
  "https://github.com/refractalize/oil-git-status.nvim",
  ft = { "oil" },
  dependencies = {
    "https://github.com/stevearc/oil.nvim",
  },
  opts = {
    show_ignored = true,
  },
}

-- Use oil.nvim as the main filer, and fyler.nvim to understand directory structure
local function show_fyler_help()
  local keymaps = {
    { key = "<CR>", desc = "Open file / directory" },
    { key = "q", desc = "Close view" },
    { key = "-", desc = "Go to parent directory" },
    { key = "gr", desc = "Go to cwd" },
    { key = "gn", desc = "Go to node" },
    { key = "zc", desc = "Collapse node" },
    { key = "zM", desc = "Collapse all" },
    { key = "g?", desc = "Show this help" },
  }

  local max_key_len = 0
  for _, km in ipairs(keymaps) do
    max_key_len = math.max(max_key_len, #km.key)
  end

  local lines = { "  Fyler Keymaps", "" }
  for _, km in ipairs(keymaps) do
    local pad = string.rep(" ", max_key_len - #km.key)
    table.insert(lines, string.format("  %s%s  │  %s", km.key, pad, km.desc))
  end
  table.insert(lines, "")

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  width = width + 2

  local height = #lines
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  })

  for _, key in ipairs({ "q", "<Esc>", "g?" }) do
    vim.keymap.set("n", key, "<cmd>close<CR>", { buffer = buf, nowait = true, silent = true })
  end
end

p[#p + 1] = {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  lazy = false, -- Necessary for `default_explorer` to work properly
  opts = {
    views = {
      finder = {
        default_explorer = false,
        delete_to_trash = true,
        mappings = {
          ["<CR>"] = "Select",
          ["q"] = "CloseView",
          ["-"] = "GotoParent",
          ["gr"] = "GotoCwd",
          ["gn"] = "GotoNode",
          ["zo"] = "ExpandNode",
          ["zc"] = "CollapseNode",
          ["zM"] = "CollapseAll",

          -- Disable defaults
          ["<C-t>"] = false,
          ["|"] = false,
          ["^"] = false,
          ["="] = false,
          ["."] = false,
          ["#"] = false,
          ["<BS>"] = false,
        },
      },
    },
  },
  config = function(_, opts)
    local fyler = require("fyler")
    fyler.setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fyler",
      callback = function()
        vim.keymap.set("n", "g?", show_fyler_help, { buffer = true, silent = true, desc = "Show Fyler help" })
      end,
    })

    vim.keymap.set("n", "<space>e", function()
      fyler.open({ kind = "float" })
    end, { desc = "Open Fyler view" })
  end,
}

-- :h aerial
p[#p + 1] = {
  "https://github.com/stevearc/aerial.nvim",
  event = "VeryLazy",
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
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
        resize_to_content = false,
      },

      -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("aerial.actions").<name>
      -- Set to `false` to remove a keymap
      keymaps = {
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
      },
    })
    vim.keymap.set("n", "<space>a", "<cmd>AerialToggle!<CR>")
  end,
}

return p
