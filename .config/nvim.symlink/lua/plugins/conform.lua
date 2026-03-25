-- Refs: https://eiji.page/blog/neovim-conform-nvim/
--       https://zenn.dev/ras96/scraps/758a0d88654ac7
--       https://github.com/LazyVim/LazyVim/discussions/3734#discussioncomment-9984800
---@type LazyPluginSpec
return {
  "https://github.com/stevearc/conform.nvim",
  event = { "InsertEnter", "CmdLineEnter" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      go = { "gofmt", "goimports" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      objcpp = { "clang_format" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      javascript = { "biome", "prettierd", stop_after_first = true },
      typescript = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", stop_after_first = true },
      json = { "biome", "prettierd", stop_after_first = true },
      jsonc = { "biome", "prettierd", stop_after_first = true },
      graphql = { "biome", "prettierd", stop_after_first = true },
    },

    formatters = {
      clang_format = {
        prepend_args = { "--style=file", "--fallback-style=LLVM" },
      },
      shfmt = {
        prepend_args = { "-i", "4" },
      },
    },

    -- From: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L683-L696
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,

    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },
  },
}
