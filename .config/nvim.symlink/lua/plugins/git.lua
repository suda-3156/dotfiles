local p = {}

p[#p + 1] = {
  "https://github.com/tpope/vim-fugitive",
  lazy = true,
}

p[#p + 1] = {
  -- GitHub integration for vim-fugitive
  "https://github.com/tpope/vim-rhubarb",
  lazy = true,
}

p[#p + 1] = {
  "https://github.com/lewis6991/gitsigns.nvim",
  lazy = true,
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
    })

    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions
    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Git Stage hunk" })
    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Git Reset hunk" })

    map("x", "<leader>gs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("x") })
    end, { desc = "Git Stage hunk" })

    map("x", "<leader>gr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("x") })
    end, { desc = "Git Reset hunk" })

    map("n", "<leader>gb", gitsigns.blame, { desc = "Git Blame" })
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line Blame" })

    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Git Stage buffer" })
    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git Reset buffer" })
    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git Preview hunk" })
    map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "Git preview hunk Inline" })

    map("n", "<leader>gq", function()
      gitsigns.setqflist("all")
    end, { desc = "Set qflist to unstaged changes" })

    -- Toggles
    map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Git Toggle line blame" })
    map("n", "<leader>gtw", gitsigns.toggle_word_diff, { desc = "Git Toggle Word diff" })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
}

p[#p + 1] = {
  "https://github.com/sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  config = function()
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git Diff" })
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git current File history" })
    vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git branch History" })

    local close = { "n", "qq", "<cmd>tabclose<cr>", { desc = "Exit Diffview" } }
    require("diffview").setup({
      keymaps = {
        view = { close },
        file_panel = { close },
        file_history_panel = { close },
      },
    })
  end,
}

return p
