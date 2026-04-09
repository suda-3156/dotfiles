-- Ref: https://eiji.page/blog/neovim-overseer-nvim/
return {
  "https://github.com/stevearc/overseer.nvim",
  keys = {
    { "<space>r", "<CMD>OverseerRun<CR>" },
    { "<space>o", "<CMD>OverseerToggle<CR>" },
  },
  config = function()
    require("overseer").setup({
      -- Configure the task list
      task_list = {
        -- Default direction. Can be "left", "right", or "bottom"
        direction = "left",
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
        max_width = { 100, 0.2 },
        -- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
        min_width = { 40, 0.1 },
        max_height = { 20, 0.2 },
        min_height = 8,
        -- Set keymap to false to remove default behavior
        -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
        -- Comment outed settings are defaults
        keymaps = {
          -- ["?"] = "keymap.show_help",
          -- ["g?"] = "keymap.show_help",
          -- ["<CR>"] = "keymap.run_action",
          -- ["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
          -- ["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
          -- ["o"] = "keymap.open",
          -- ["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
          -- ["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
          -- ["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
          -- ["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
          -- ["<C-q>"] = {
          --   "keymap.run_action",
          --   opts = { action = "open output in quickfix" },
          --   desc = "Open task output in the quickfix",
          -- },
          -- ["p"] = "keymap.toggle_preview",
          -- ["{"] = "keymap.prev_task",
          -- ["}"] = "keymap.next_task",
          -- ["<C-k>"] = "keymap.scroll_output_up",
          -- ["<C-j>"] = "keymap.scroll_output_down",
          -- ["g."] = "keymap.toggle_show_wrapped",
          -- ["q"] = { "<CMD>close<CR>", desc = "Close task list" },
        },
      },
    })
  end,
}
