---@type LazyPluginSpec
return {
  "monaqa/dial.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "+",
      function()
        require("dial.map").manipulate("increment", "normal")
      end,
      mode = { "n", "v" },
      desc = "Increment number under the cursor",
    },
    {
      "-",
      function()
        require("dial.map").manipulate("decrement", "normal")
      end,
      mode = { "n", "v" },
      desc = "Decrement number under the cursor",
    },
    {
      "g+",
      function()
        require("dial.map").manipulate("increment", "gnormal")
      end,
      mode = { "n", "v" },
      desc = "Increment number under the cursor",
    },
    {
      "g-",
      function()
        require("dial.map").manipulate("decrement", "gnormal")
      end,
      mode = { "n", "v" },
      desc = "Decrement number under the cursor",
    },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,

        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%d/%m/%Y"],
        augend.date.alias["%m/%d/%y"],
        augend.date.alias["%d/%m/%y"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%-m/%-d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%Y年%-m月%-d日"],
        augend.date.alias["%Y年%-m月%-d日(%ja)"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],

        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.constant.alias.Bool,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.semver.alias.semver,
        augend.paren.alias.lua_str_literal,

        augend.case.new({
          types = {
            "camelCase",
            "snake_case",
            "PascalCase",
            "kebab-case",
            "SCREAMING_SNAKE_CASE",
          },
          cyclic = true,
        }),
      },
    })
  end,
}
