-- From: https://eiji.page/blog/neovim-luasnip-intro/
---@type LazyPluginSpec
return {
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
      paths = { "~/dotfiles/.config/nvim.symlink/snippet" },
      override_priority = 2000,
    })

    require("luasnip").filetype_extend("typescript", { "javascript" })
    vim.api.nvim_create_user_command("EditSnippet", ':lua require("luasnip.loaders").edit_snippet_files()', {})
    vim.keymap.set("n", "<leader>es", "<cmd>EditSnippet<cr>", { desc = "Edit Snippet" })
  end,
}
