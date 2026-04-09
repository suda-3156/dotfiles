local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "snptone", name = "Snippet for LuaSnip" },
  fmt(
    [=[
snpt[#snpt + 1] = s(
  { trig = "<trigger>", name = "<tittle>" },
  fmt(
    [[
<cursor>
]],
    { cursor = i(0) }
  )
)
]=],
    { cursor = i(0), trigger = i(1), tittle = i(2) },
    { delimiters = "<>" }
  )
)

snpt[#snpt + 1] = s(
  { trig = "snpt", name = "Snippet for LuaSnip" },
  fmt(
    [=[
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "<trigger>", name = "<tittle>" },
  fmt(
    [[
<cursor>
]],
    { cursor = i(0) }
  )
)

return snpt
]=],
    { cursor = i(0), trigger = i(1), tittle = i(2) },
    { delimiters = "<>" }
  )
)

return snpt
