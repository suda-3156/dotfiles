---@type LazyPluginSpec
return {
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

--     Old text                    Command         New text
--------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
