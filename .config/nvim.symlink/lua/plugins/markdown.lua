-- From: https://eiji.page/blog/neovim-render-markdown-nvim/
return {
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "[T]oggle [M]arkdown view" } },
  },
  opts = {
    heading = {
      width = "block",
      left_pad = 0,
      right_pad = 4,
      icons = {},
    },

    code = {
      -- Whether to conceal nodes at the top and bottom of code blocks.
      conceal_delimiters = false,
      -- Whether to include the language name above code blocks.
      language_name = false,
      -- Whether to include the language info above code blocks.
      language_info = true,
      -- Amount of padding to add around the language.
      -- If a float < 1 is provided it is treated as a percentage of available window space.
      language_pad = 2,
      -- Width of the code block background.
      -- | block | width of the code block  |
      -- | full  | full width of the window |
      width = "full",
      -- Amount of margin to add to the left of code blocks.
      -- If a float < 1 is provided it is treated as a percentage of available window space.
      -- Margin available space is computed after accounting for padding.
      left_margin = 0,
      -- Amount of padding to add to the left of code blocks.
      -- If a float < 1 is provided it is treated as a percentage of available window space.
      left_pad = 2,
      -- Amount of padding to add to the right of code blocks when width is 'block'.
      -- If a float < 1 is provided it is treated as a percentage of available window space.
      right_pad = 2,
      -- Determines how the top / bottom of code block are rendered.
      -- | none  | do not render a border                               |
      -- | thick | use the same highlight as the code body              |
      -- | thin  | when lines are empty overlay the above & below icons |
      -- | hide  | conceal lines unless language name or icon is added  |
      border = "thin",
      -- Padding to add to the left & right of inline code.
      inline_pad = 1,
    },

    checkbox = {
      checked = { scope_highlight = "@markup.strikethrough" },
      custom = {
        todo = { raw = "", rendered = "", highlight = "" },
        canceled = {
          raw = "[-]",
          rendered = "󱘹",
          scope_highlight = "@markup.strikethrough",
        },
      },
    },
  },
}
