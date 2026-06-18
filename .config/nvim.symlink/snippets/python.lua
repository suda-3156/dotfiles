local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "test", name = "Test for algorithm" },
  fmt(
    [[
from typing import TypedDict, Any, List
from dataclasses import dataclass


TestCase = TypedDict("TestCase", {{"input": Any, "want": Any}})


test_cases: List[TestCase] = [{cursor}]


@dataclass
class Tests:
    s: {class1}

    def test(self) -> None:
        for tc in test_cases:
            result = self.s.{func}(**tc["input"])

            if result != tc["want"]:
                print(
                    f"test failed for input: {{tc['input']}}, want: {{tc['want']}}, result: {{result}}."
                )
                continue

            print(f"test passed for input: {{tc['input']}}")


def main():
    s = {class2}()
    t = Tests(s)

    t.test()


if __name__ == "__main__":
    main()
]],
    { cursor = i(0), class1 = i(1, "Solutions"), func = i(2, "first"), class2 = i(1, "Solutions") }
  )
)

snpt[#snpt + 1] = s(
  { trig = "alg", name = "algorithm basic input" },
  fmt(
    [[
import sys


def main():
    data = sys.stdin.read().split("\n")
    {cursor}


if __name__ == "__main__":
    main()
]],
    { cursor = i(0) }
  )
)

return snpt
