local function show_help()
  local keymaps = {
    { key = "<CR>", desc = "Open file / directory" },
    { key = "q / <C-c>", desc = "Close view" },
    { key = "-", desc = "Go to parent directory" },
    { key = "gr", desc = "Go to cwd" },
    { key = "gn", desc = "Go to node" },
    { key = "zc", desc = "Collapse node" },
    { key = "zM", desc = "Collapse all" },
    { key = "g?", desc = "Show this help" },
  }

  local max_key_len = 0
  for _, km in ipairs(keymaps) do
    max_key_len = math.max(max_key_len, #km.key)
  end

  local lines = { "  Fyler Keymaps", "" }
  for _, km in ipairs(keymaps) do
    local pad = string.rep(" ", max_key_len - #km.key)
    table.insert(lines, string.format("  %s%s  │  %s", km.key, pad, km.desc))
  end
  table.insert(lines, "")

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  width = width + 2

  local height = #lines
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  })

  for _, key in ipairs({ "q", "<Esc>", "g?" }) do
    vim.keymap.set("n", key, "<cmd>close<CR>", { buffer = buf, nowait = true, silent = true })
  end
end

return { -- Use oil.nvim as the main filer, and fyler.nvim to understand directory structure
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  lazy = false, -- Necessary for `default_explorer` to work properly
  opts = {
    views = {
      finder = {
        default_explorer = false,
        delete_to_trash = true,
        mappings = {
          ["<CR>"] = "Select",
          ["q"] = "CloseView",
          ["<C-c>"] = "CloseView",
          ["-"] = "GotoParent",
          ["gr"] = "GotoCwd",
          ["gn"] = "GotoNode",
          ["zo"] = "ExpandNode",
          ["zc"] = "CollapseNode",
          ["zM"] = "CollapseAll",

          -- Disable defaults
          ["<C-t>"] = false,
          ["|"] = false,
          ["^"] = false,
          ["="] = false,
          ["."] = false,
          ["#"] = false,
          ["<BS>"] = false,
        },
      },
    },
  },
  config = function(_, opts)
    local fyler = require("fyler")
    fyler.setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fyler",
      callback = function()
        vim.keymap.set("n", "g?", show_help, { buffer = true, silent = true, desc = "Show Fyler help" })
      end,
    })

    vim.keymap.set("n", "<space>e", function()
      fyler.open({ kind = "float" })
    end, { desc = "Open Fyler view" })
  end,
}
