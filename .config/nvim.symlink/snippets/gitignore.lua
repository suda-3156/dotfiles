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
.local/

# binary
*.bin
*.out
out/
build/
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

snpt[#snpt + 1] = s(
  { trig = "lab", name = ".gitignore for jupyter lab" },
  fmt(
    [[
.venv/
.ipynb_checkpoints/
]],
    {}
  )
)

snpt[#snpt + 1] = s(
  { trig = "tf", name = ".gitignore for terraform" },
  fmt(
    [[
# Terraform
**/.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
override.tf
override.tf.json
*_override.tf
*_override.tf.json
crash.log
crash.*.log
.terraform.tfstate.lock.info
.terraformrc
terraform.rc
]],
    {}
  )
)

snpt[#snpt + 1] = s(
  { trig = "rust", name = ".gitignore for rust" },
  fmt(
    [[
# ruse
debug
target
**/*.rs.bk
*.pdb
**/mutants.out*/
rustc-ice-*.txt
]],
    {}
  )
)

return snpt
