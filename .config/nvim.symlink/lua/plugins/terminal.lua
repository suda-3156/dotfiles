local p = {}

p[#p + 1] = {
  -- tmux & split window navigation
  "https://github.com/christoomey/vim-tmux-navigator",
  event = "VeryLazy",
}

p[#p + 1] = {
  "https://github.com/akinsho/toggleterm.nvim",
  version = "*", -- Use the latest version
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      open_mapping = "<C-t>",

      -- direction of the terminal (horizontal, vertical, float)
      direction = "float",

      hide_numbers = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true, -- close the terminal window when the process exits

      on_open = function(term)
        -- Only override C-hjkl for float terminals; non-float ones keep default navigation.
        if term.direction ~= "float" then
          return
        end

        -- Move to the adjacent tmux pane without closing the float.
        -- nvim preserves window state while tmux switches panes, so the float
        -- stays open and regains focus automatically when returning to this pane.
        -- vim-tmux-navigator handles normal windows; the float needs its own mapping
        -- because it has no vim neighbors in any direction.
        local opts = { buffer = term.bufnr, noremap = true, silent = true }
        local nav = { h = "L", j = "D", k = "U", l = "R" }
        for key, tmux_dir in pairs(nav) do
          vim.keymap.set("t", "<C-" .. key .. ">", function()
            vim.fn.system("tmux select-pane -" .. tmux_dir)
          end, opts)
        end
      end,
    })
  end,
}

return p
