local p = {}

-- From: https://cmp.saghen.dev/installation
-- Refs: https://eiji.page/blog/neovim-blink-cmp-intro/
p[#p + 1] = {
  "https://github.com/saghen/blink.cmp",
  version = "1.*", -- to download pre-built binaries
  event = { "InsertEnter", "CmdLineEnter" },

  opts = {
    keymap = {
      preset = "default",

      -- Following commentouted lines are defined by default preset
      ["<C-\\>"] = { "show", "show_documentation", "hide_documentation" },
      -- ["<C-e>"] = { "hide", "fallback" },
      -- ["<C-y>"] = { "select_and_accept", "fallback" },

      -- ["<Up>"] = { "select_prev", "fallback" },
      -- ["<Down>"] = { "select_next", "fallback" },
      -- ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      -- ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      --
      -- ["<Tab>"] = { "snippet_forward", "fallback" },
      -- ["<S-Tab>"] = { "snippet_backward", "fallback" },

      -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        ghost_text = {
          enabled = true,
        },
      },
    },

    appearance = {
      nerd_font_variant = "normal",
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    snippets = { preset = "luasnip" },
    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      per_filetype = {
        markdown = { "snippets", "lsp", "path" },
        mdx = { "snippets", "lsp", "path" },
      },
    },
  },
  opts_extend = { "source.default" },
}

-- From: https://eiji.page/blog/neovim-luasnip-intro/
p[#p + 1] = {
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  version = "v2.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  build = "make install_jsregexp",
  config = function()
    require("luasnip.loaders.from_vscode").load({
      override_priority = 1000,
    })

    require("luasnip.loaders.from_lua").load({
      paths = { "~/dotfiles/.config/nvim.symlink/snippets" },
      override_priority = 2000,
    })

    require("luasnip").filetype_extend("typescript", { "javascript" })

    vim.api.nvim_create_user_command("EditSnippet", ':lua require("luasnip.loaders").edit_snippet_files()', {})
    vim.keymap.set("n", "<leader>es", "<cmd>EditSnippet<cr>", { desc = "Edit Snippet" })
    vim.keymap.set("n", "<leader>is", ":lua require'luasnip'.log.open()", { desc = "Info Snippet" })
  end,
}

return p
