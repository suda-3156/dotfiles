local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "go-task", name = "taskfile init template" },
  fmt(
    [[
version: "3"

includes:
  go:
    taskfile: ./go/taskfile.yaml
    dir: .
    vars:
      APP_NAME: go-app

tasks:
  default:
    cmds:
      - task -l --sort none
    silent: true
  {cursor}
]],
    { cursor = i(0) }
  )
)

snpt[#snpt + 1] = s(
  { trig = "pyci", name = "python ci" },
  fmt(
    [[
version: "3"{cursor}

tasks:
  default:
    cmds:
      - task -l --sort none
    silent: true

  test:
    desc: "Run tests"
    cmds:
      - |
        echo "=== Running tests ==="
        # - uv run pytest
        echo "No tests defined yet"
    silent: true

  lint-format:
    desc: "Run linter and formatter"
    cmds:
      - |
        echo "=== Running linter and formatter ==="
        uv run ruff check --fix
    silent: true

  typecheck:
    desc: "Run type checker"
    cmds:
      - |
        echo "=== Running type checker ==="
        uv run pyright .
    silent: true

  sort-imports:
    desc: "Sort imports"
    cmds:
      - |
        echo "=== Sorting imports ==="
        uv run isort .
    silent: true

  pre-commit:
    desc: "Run all ci checks"
    cmds:
      - echo "=== Run all ci checks ==="
      - task: lint-format
      - task: typecheck
      - task: sort-imports
      - task: test
      - echo "=== All ci checks passed ==="
    silent: true
]],
    { cursor = i(0) }
  )
)

return snpt
