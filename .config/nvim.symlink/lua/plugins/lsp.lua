local p = {}

-- From: kickstart.nvim
p[#p + 1] = {
  "https://github.com/neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Useful status updates for LSP.
    {
      "https://github.com/j-hui/fidget.nvim",
      opts = {
        progress = { display = { done_icon = "✓" } },
        notification = { window = { winblend = 0 } },
      },
    },
  },
}

p[#p + 1] = {
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  lazy = false,
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "simple",
      transparent_bg = true,
      blend = { factor = 0 },

      options = {
        multilines = { enabled = true },
        show_source = { enabled = true },
        show_code = { enabled = true },

        -- To automatically hide inline diagnostics when opening Neovim’s diagnostic
        -- float windows. By default <C-w>d is set to open the window.
        override_open_float = true,

        break_line = {
          enabled = true,
          -- Number of characters before inserting a line break
          after = 100,
        },
        format = function(diag)
          if diag.code == nil then
            return diag.message .. " [" .. diag.source .. "]"
          end
          return diag.message .. " [" .. diag.source .. ":" .. diag.code .. "]"
        end,
      },
    })

    -- :h vim.diagnostic.Opts
    vim.diagnostic.config({
      virtual_text = false, -- Disable Neovim's default virtual text diagnostics
    })
  end,
}

-- From: README.md
p[#p + 1] = {
  "https://github.com/lewis6991/hover.nvim",
  event = "LspAttach",
  config = function()
    require("hover").config({
      providers = {
        "hover.providers.diagnostic",
        "hover.providers.lsp",
        -- "hover.providers.dap",
        "hover.providers.man",
        "hover.providers.dictionary",
        -- Optional, disabled by default:
        "hover.providers.gh",
        "hover.providers.gh_user",
        -- 'hover.providers.jira',
        "hover.providers.fold_preview",
        "hover.providers.highlight",
      },
      preview_opts = {
        border = "single",
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = false,
      title = false,
    })

    -- Setup keymaps
    vim.keymap.set("n", "K", function()
      require("hover").open()
    end, { desc = "hover.nvim (open)" })

    vim.keymap.set("n", "gK", function()
      require("hover").enter()
    end, { desc = "hover.nvim (enter)" })

    vim.keymap.set("n", "<C-p>", function()
      require("hover").switch("previous")
    end, { desc = "hover.nvim (previous source)" })

    vim.keymap.set("n", "<C-n>", function()
      require("hover").switch("next")
    end, { desc = "hover.nvim (next source)" })
  end,
}

-- p[#p + 1] = {
--   "https://github.com/rachartier/tiny-code-action.nvim",
--   dependencies = {
--     { "nvim-lua/plenary.nvim" },
--     { "nvim-telescope/telescope.nvim" },
--   },
--   event = "LspAttach",
--   config = function()
--     require("tiny-code-action").setup({
--       backend = "delta",
--     })
--
--     vim.keymap.set({ "n", "x" }, "gA", function()
--       require("tiny-code-action").code_action({})
--     end, { desc = "Goto Code Action" })
--   end,
-- }

p[#p + 1] = {
  "ray-x/lsp_signature.nvim",
  enabled = false,
  event = "InsertEnter",
  opts = {},
}

-- p[#p + 1] = {
--   "https://github.com/folke/lazydev.nvim",
--   ft = "lua",
--   opts = {
--     library = {
--       -- See the configuration section for more details
--       -- Load luvit types when the `vim.uv` word is found
--       { path = "${3rd}/luv/library", words = { "vim%.uv" } },
--     },
--   },
-- }

p[#p + 1] = {
  "https://github.com/folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}

return p
