local p = {}

-- applescript
p[#p + 1] = {
  "https://github.com/vim-scripts/applescript.vim",
  ft = { "applescript" },
}

-- golang
p[#p + 1] = {
  "https://github.com/ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  opts = {
    icons = false,
    diagnostic = false,
    lsp_cfg = false,
    lsp_gofumpt = false,
    lsp_keymaps = false,
    lsp_codelens = false,
    lsp_document_formatting = false,
    lsp_inlay_hints = { enable = false },
    dap_debug = false,
    dap_debug_keymap = false,
    textobjects = false,
    trouble = false,
    luasnip = false,
    run_in_floaterm = false,
  },
}

return p
