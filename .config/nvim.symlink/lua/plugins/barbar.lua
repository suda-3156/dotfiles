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
    { "<S-h>", "<cmd>BufferPrevious<cr>", mode = { "n" }, desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferNext<cr>", mode = { "n" }, desc = "Next Buffer" },
    { "<leader>cbr", "<Cmd>BufferCloseBuffersRight<CR>", mode = { "n" }, desc = "Close Buffers to the Right" },
    { "<leader>cbl", "<Cmd>BufferCloseBuffersLeft<CR>", mode = { "n" }, desc = "Close Buffers to the Left" },
  },

  config = function()
    require("barbar").setup({
      auto_hide = 0,
    })

    -- When deleting a buffer, modes.nvim detect "d" key and judge it's in delete mode.
    -- Addressing this issue.
    vim.keymap.set("n", "<leader>d", function()
      local bufnr = vim.api.nvim_get_current_buf()

      -- Neovimのイベントループが落ち着く（安全な状態になる）のを待ってから削除
      vim.schedule(function()
        vim.cmd("bd " .. bufnr)
        -- 念のため、モード変更イベントを強制発火させて色を確実に戻す
        vim.api.nvim_exec_autocmds("ModeChanged", { pattern = "*:*", modeline = false })
      end)
    end, { desc = "Close buffer (Fix modes.nvim stuck)" })

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

    -- Highlights
    local function highlight()
      vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferCurrent", { link = "OkMsg" })
      vim.api.nvim_set_hl(0, "BufferInactive", { link = "Comment", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferVisible", { link = "CursorLine" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = highlight })
    highlight()
  end,
}
