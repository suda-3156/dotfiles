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
  -- spellchecker:off
  -- stylua: ignore start
  keys = {
    { "<leader>d",  "<cmd>BufferClose<cr>",               desc = "Close Buffer" },
    { "<S-h>",       "<cmd>BufferPrevious<cr>",           desc = "Prev Buffer" },
    { "<S-l>",       "<cmd>BufferNext<cr>",               desc = "Next Buffer" },
    { "<leader>cbr", "<Cmd>BufferCloseBuffersRight<CR>",  desc = "[C]ose [B]uffers to the [R]ight" },
    { "<leader>cbl", "<Cmd>BufferCloseBuffersLeft<CR>",   desc = "[C]ose [B]uffers to the [L]eft" },
  },
  -- stylua: ignore end
  -- spellchecker:on

  config = function()
    require("barbar").setup({
      auto_hide = 0,
    })

    -- Close all buffers except those visible in windows
    local function close_all_but_visible()
      -- Get all buffers currently visible in windows
      local visible_buffers = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        visible_buffers[buf] = true
      end

      -- Close all other buffers
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if visible_buffers[bufnr] then
          goto continue
        end

        -- Only close if it's a normal buffer (not special buffers)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
        if buftype ~= "" then
          goto continue
        end

        -- and it doesn't have any unsaved changes
        local is_modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
        if is_modified then
          goto continue
        end

        pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
        ::continue::
      end
    end
    vim.keymap.set("n", "<leader>D", function()
      close_all_but_visible()
    end, { desc = "Close All Buffers except Visible" })

    -- transparent tab line
    local function fix_tabfill()
      vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_tabfill })
    fix_tabfill()
  end,
}
