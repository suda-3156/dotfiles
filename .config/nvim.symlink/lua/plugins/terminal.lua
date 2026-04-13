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
    })
  end,
}

return p
