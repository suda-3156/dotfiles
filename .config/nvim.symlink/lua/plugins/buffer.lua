---@type LazyPluginSpec
return {
  "https://github.com/romgrk/barbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    { "<leader>cab", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "[C]ose [A]ll [B]uffers except for Current" },
    { "<leader>cbr", "<Cmd>BufferCloseBuffersRight<CR>",  desc = "[C]ose [B]uffers to the [R]ight" },
    { "<leader>cbl", "<Cmd>BufferCloseBuffersLeft<CR>",   desc = "[C]ose [B]uffers to the [L]eft" },
    { "<S-h>",       "<cmd>BufferPrevious<cr>",           desc = "Prev Buffer" },
    { "<S-l>",       "<cmd>BufferNext<cr>",               desc = "Next Buffer" },
    { "<leader>dd",  "<cmd>BufferClose<cr>",              desc = "Close Buffer" },
  },

  config = function()
    require("barbar").setup({
      auto_hide = 0,
    })

    -- transparent tab line
    local function fix_tabfill()
      vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_tabfill })
    fix_tabfill()
  end,
}
