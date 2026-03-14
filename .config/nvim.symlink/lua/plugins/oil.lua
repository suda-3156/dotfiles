return {
  {
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
          ["`"] = { "actions.cd", mode = "n" },
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
  },
  { -- Show git status in oil directory listings
    "https://github.com/refractalize/oil-git-status.nvim",
    dependencies = {
      "https://github.com/stevearc/oil.nvim",
    },
    opts = {},
  },
}
