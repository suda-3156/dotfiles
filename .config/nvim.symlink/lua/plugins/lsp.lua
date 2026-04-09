local p = {}

-- From: kickstart.nvim
---@type LazyPluginSpec
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
  enabled = false,
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "simple",
      transparent_bg = true,
    })
    vim.diagnostic.config({ virtual_text = true }) -- Disable Neovim's default virtual text diagnostics
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
      title = true,
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

p[#p + 1] = {
  "https://github.com/rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  event = "LspAttach",
  config = function()
    require("tiny-code-action").setup({
      backend = "delta",
    })

    vim.keymap.set({ "n", "x" }, "gA", function()
      require("tiny-code-action").code_action({})
    end, { desc = "Goto Code Action" })
  end,
}

p[#p + 1] = {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {},
}

p[#p + 1] = {
  "https://github.com/folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

return p
