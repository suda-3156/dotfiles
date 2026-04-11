import * as k from "karabiner_ts";

export const fnNumbersRules = [
  k.rule("fn + wersdfxcv, space bar => 1 ~ 0").manipulators([
    k
      .map({
        key_code: "w",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("1"),
    k
      .map({
        key_code: "e",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("2"),
    k
      .map({
        key_code: "r",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("3"),
    k
      .map({
        key_code: "s",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("4"),
    k
      .map({
        key_code: "d",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("5"),
    k
      .map({
        key_code: "f",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("6"),
    k
      .map({
        key_code: "x",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("7"),
    k
      .map({
        key_code: "c",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("8"),
    k
      .map({
        key_code: "v",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("9"),
    k
      .map({
        key_code: "spacebar",
        modifiers: { mandatory: ["fn"], optional: ["shift"] },
      })
      .to("0"),
  ]),

  k
    .rule("fn + jkl => `-=")
    .manipulators([
      k.map("j", "fn").to("grave_accent_and_tilde"),
      k.map("k", "fn").to("hyphen"),
      k.map("l", "fn").to("equal_sign"),
      k.map("j", "fn", "shift").to("grave_accent_and_tilde", "shift"),
      k.map("k", "fn", "shift").to("hyphen", "shift"),
      k.map("l", "fn", "shift").to("equal_sign", "shift"),
    ]),
];
