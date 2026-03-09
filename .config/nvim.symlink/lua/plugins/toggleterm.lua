return {
  'akinsho/toggleterm.nvim',
  version = '*', -- Use the latest version
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-\>]], -- mapping to toggle the terminal

      -- Use with direction = 'horizontal' or 'vertical'
      -- size = 50,
      -- direction = 'vertical',
      direction = 'float', -- direction of the terminal (horizontal, vertical, float)

      shade_terminals = true,
      shading_factor = 2, -- the percentage by which to lighten dark terminal background, default: -30
      hide_numbers = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true, -- close the terminal window when the process exits
    }
  end,
}
