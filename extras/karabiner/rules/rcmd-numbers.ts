import * as k from "karabiner_ts";

export const rCmdNumberRules = [
  k.rule("right_command + wersdfxcv, space bar => 1 ~ 0").manipulators([
    k
      .map({
        key_code: "w",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("1"),
    k
      .map({
        key_code: "e",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("2"),
    k
      .map({
        key_code: "r",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("3"),
    k
      .map({
        key_code: "s",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("4"),
    k
      .map({
        key_code: "d",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("5"),
    k
      .map({
        key_code: "f",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("6"),
    k
      .map({
        key_code: "x",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("7"),
    k
      .map({
        key_code: "c",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("8"),
    k
      .map({
        key_code: "v",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("9"),
    k
      .map({
        key_code: "spacebar",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("0"),
  ]),

  k.rule("right_command + jkl => `-=").manipulators([
    k
      .map({
        key_code: "j",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("grave_accent_and_tilde"),
    k
      .map({
        key_code: "k",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("hyphen"),
    k
      .map({
        key_code: "l",
        modifiers: { mandatory: ["right_command"], optional: ["shift"] },
      })
      .to("equal_sign"),
  ]),
];
