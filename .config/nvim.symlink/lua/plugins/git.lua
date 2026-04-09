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
    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [S]tage hunk" }) --spellchecker:disable-line
    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset hunk" })

    map("x", "<leader>gs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("x") })
    end, { desc = "[G]it [S]tage hunk" }) --spellchecker:disable-line

    map("x", "<leader>gr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("x") })
    end, { desc = "[G]it [R]eset hunk" })

    map("n", "<leader>gb", gitsigns.blame, { desc = "[G]it [B]lame" })
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle current line [B]lame" })

    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" }) --spellchecker:disable-line
    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [P]review hunk" })
    map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "[G]it preview hunk [I]nline" })

    map("n", "<leader>gq", function()
      gitsigns.setqflist("all")
    end, { desc = "Set qflist to unstaged changes" })

    -- Toggles
    map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "[G]it [T]oggle line [b]lame" })
    map("n", "<leader>gtw", gitsigns.toggle_word_diff, { desc = "[G]it [T]oggle [W]ord diff" })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
}

p[#p + 1] = {
  "https://github.com/sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  config = function()
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iff" })
    vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "[G]it current [F]ile history" })
    vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "[G]it branch [H]istory" })

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
