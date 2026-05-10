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
  config = function()
    local autotag = require("nvim-ts-autotag")

    autotag.setup({
      aliases = {
        ["svelte"] = "html",
      },
    })
  end,
}

p[#p + 1] = {
  "https://github.com/Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>ts", "<cmd>TSJToggle<cr>", desc = "TreeSJ Toggle" },
  },
  opts = {},
}

-- p[#p + 1] = {
--   "https://github.com/hrsh7th/nvim-insx",
--   event = "InsertEnter",
--   config = function()
--     require("insx.preset.standard").setup()
--     local insx = require("insx")
--
--     -- html tag like
--     local void_elements = {
--       area = true,
--       base = true,
--       br = true,
--       col = true,
--       embed = true,
--       hr = true,
--       img = true,
--       input = true,
--       link = true,
--       meta = true,
--       param = true,
--       source = true,
--       track = true,
--       wbr = true,
--     }
--     local html_fts = { html = true, xml = true, jsx = true, tsx = true, vue = true, svelte = true, htmldjango = true }
--     insx.add(">", {
--       enabled = function(ctx)
--         return html_fts[vim.bo.filetype] and ctx.match([=[<\([a-zA-Z][a-zA-Z0-9]*\)\%#]=])
--       end,
--       action = function(ctx)
--         local tag = ctx.before():match("<([a-zA-Z][a-zA-Z0-9]*)%s*$")
--         if tag and not void_elements[tag:lower()] then
--           local row, col = ctx.row(), ctx.col()
--           ctx.send("></" .. tag .. ">")
--           ctx.move(row, col + 1)
--         else
--           ctx.send(">")
--         end
--       end,
--     })
--
--     -- From: https://zenn.dev/hrsh7th/articles/dd7ea5a0e4a7b9
--     insx.add("<Space>", {
--       enabled = function(ctx)
--         -- カーソル左側がマルチバイト文字である
--         local before_non_ascii = ctx.match([=[[^\x00-\x7F]\%#]=])
--         -- カーソル右側が ASCII 文字列で、スペースなしでマルチバイトが続いている
--         local after_ascii_without_space = ctx.match([=[\%#[\x00-\x7F]\+[^\x00-\x7F]]=])
--         return before_non_ascii and after_ascii_without_space
--       end,
--       action = function(ctx)
--         ctx.send("<Space>")
--         local row, col = ctx.row(), ctx.col()
--         ctx.move(unpack(ctx.search([=[\%#[\x00-\x7F]\+\zs]=])))
--         ctx.send("<Space>")
--         ctx.move(row, col)
--       end,
--     })
--   end,
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
  event = { "BufReadPost", "BufNewFile" },
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
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}

return p
