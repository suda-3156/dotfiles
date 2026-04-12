local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "work", name = ".gitignore for workspace" },
  fmt(
    [[
# env
*.env*
!.env.example
!.env.test
# secrets variables are written in .env* files, and .envrc is only used to load them
!.envrc

# work
.local.*
local/

# binary
*.bin
*.out
]],
    {}
  )
)

snpt[#snpt + 1] = s(
  { trig = "py", name = ".gitignore for python" },
  fmt(
    [[
.venv/
.pytest_cache/
.ruff_cache/
__pycache__/
]],
    {}
  )
)

return snpt
