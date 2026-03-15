-- From: https://cmp.saghen.dev/installation
-- Refs: https://eiji.page/blog/neovim-blink-cmp-intro/
---@type LazyPluginSpec
return {
  "https://github.com/saghen/blink.cmp",
  version = "1.*", -- to download pre-built binaries
  event = { "InsertEnter", "CmdLineEnter" },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",

      -- Following commentouted lines are defined by default preset
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      -- ["<C-e>"] = { "hide", "fallback" },
      -- ["<C-y>"] = { "select_and_accept", "fallback" },
      --
      -- ["<Up>"] = { "select_prev", "fallback" },
      -- ["<Down>"] = { "select_next", "fallback" },
      -- ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      -- ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      --
      -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      --
      -- ["<Tab>"] = { "snippet_forward", "fallback" },
      -- ["<S-Tab>"] = { "snippet_backward", "fallback" },
      --
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
