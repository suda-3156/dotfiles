local p = {}

p[#p + 1] = {
  "https://github.com/windwp/nvim-autopairs",
  event = "InsertEnter",
  config = true,
  opts = {},
}

p[#p + 1] = {
  "https://github.com/windwp/nvim-ts-autotag",
  event = "InsertEnter",
  -- Usage:
  -- Before        Input         After
  -- ------------------------------------
  -- <div           >              <div></div>
  -- <div></div>    ciwspan<esc>   <span></span>
  -- ------------------------------------
}

p[#p + 1] = {
  "https://github.com/Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
  keys = {
    { "<leader>tt", "<cmd>TSJToggle<cr>", desc = "[T]reeSJ [T]oggle" },
    { "<leader>tj", "<cmd>TSJJoin<cr>", desc = "[T]reeSJ [J]oin" },
    { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "[T]reeSJ [S]plit" },
  },
}

-- p[#p + 1] = {
--   "https://github.com/hrsh7th/nvim-insx",
--   event = "InsertEnter",
--   config = true,
-- }

--     Old text                    Command         New text
--------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
p[#p + 1] = {
  "https://github.com/kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  opts = {
    surrounds = {
      -- Replace open and close brackets behaviours with each other
      -- By default open brackets are inserted with spaces and closed brackets are inserted without spaces
      ["{"] = {
        add = function()
          return { { "{" }, { "}" } }
        end,
      },
      ["}"] = {
        add = function()
          return { { "{ " }, { " }" } }
        end,
      },
      ["["] = {
        add = function()
          return { { "[" }, { "]" } }
        end,
      },
      ["]"] = {
        add = function()
          return { { "[ " }, { " ]" } }
        end,
      },
      ["<"] = {
        add = function()
          return { { "<" }, { ">" } }
        end,
      },
      [">"] = {
        add = function()
          return { { "< " }, { " >" } }
        end,
      },
      ["("] = {
        add = function()
          return { { "(" }, { ")" } }
        end,
      },
      [")"] = {
        add = function()
          return { { "( " }, { " )" } }
        end,
      },
    },
    aliases = {
      ["a"] = "<",
      ["A"] = ">",
      ["b"] = "(",
      ["B"] = ")",
      ["m"] = "{",
      ["M"] = "}",
      ["r"] = "[",
      ["R"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "{", "[", "(", "<", '"', "'", "`" },
    },
  },
}

p[#p + 1] = {
  "https://github.com/andymass/vim-matchup",
  event = "BufReadPost",
  ---@type matchup.Config
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}

return p
