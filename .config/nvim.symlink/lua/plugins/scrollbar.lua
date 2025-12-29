return {
  "petertriho/nvim-scrollbar",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    -- https://github.com/shaunsingh/nord.nvim/blob/master/lua/nord/named_colors.lua
    local colors = require("nord.named_colors")
    -- https://github.com/okm321/dotfiles/blob/main/nvim/lua/plugins/utility/nvim-scrollbar.lua
    require("scrollbar").setup({
			excluded_filetypes = {
				"neo-tree",
				"dashboard",
				"dropbar_menu",
				"snacks_picker_print",
				"snacks_picker_list",
				"snacks_picker_preview",
				"Glance",
				"TelescopePrompt",
				"AvanteInput",
				"Avante",
				"AvanteSelectedFiles",
				"snacks_picker_input",
			},
    })
  end,
}
