return {
  "https://github.com/akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", mode = { "n" }, desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", mode = { "n" }, desc = "Next Buffer" },
    { "<leader>cbr", "<cmd>BufferLineCloseRight<cr>", mode = { "n" }, desc = "Close Buffers to the Right" },
    { "<leader>cbl", "<cmd>BufferLineCloseLeft<cr>", mode = { "n" }, desc = "Close Buffers to the Left" },
  },
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    })

    -- Schedule to avoid modes.nvim detecting "d" as delete mode
    vim.keymap.set("n", "<leader>d", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.schedule(function()
        vim.cmd("bd " .. bufnr)
        vim.api.nvim_exec_autocmds("ModeChanged", { pattern = "*:*", modeline = false })
      end)
    end, { desc = "Close buffer" })

    -- Close all buffers except those visible in windows
    vim.keymap.set("n", "<leader>D", function()
      local visible = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        visible[vim.api.nvim_win_get_buf(win)] = true
      end
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if visible[bufnr] then
          goto continue
        end
        if vim.bo[bufnr].buftype ~= "" then
          goto continue
        end
        if vim.bo[bufnr].modified then
          goto continue
        end
        pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
        ::continue::
      end
    end, { desc = "Close All Buffers except Visible" })

    -- Highlights
    local function highlight()
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { link = "OkMsg" })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "Comment", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { link = "CursorLine" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = highlight })
    highlight()
  end,
}
