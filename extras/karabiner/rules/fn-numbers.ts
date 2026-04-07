import * as k from "karabiner_ts";

export const fnNumbersRules = [
  k
    .rule("fn + wersdfxcv, space bar => 1 ~ 0")
    .manipulators([
      k.map("w", "fn").to("1"),
      k.map("e", "fn").to("2"),
      k.map("r", "fn").to("3"),
      k.map("s", "fn").to("4"),
      k.map("d", "fn").to("5"),
      k.map("f", "fn").to("6"),
      k.map("x", "fn").to("7"),
      k.map("c", "fn").to("8"),
      k.map("v", "fn").to("9"),
      k.map("spacebar", "fn").to("0"),
      k.map("w", "fn", "shift").to("1", "shift"),
      k.map("e", "fn", "shift").to("2", "shift"),
      k.map("r", "fn", "shift").to("3", "shift"),
      k.map("s", "fn", "shift").to("4", "shift"),
      k.map("d", "fn", "shift").to("5", "shift"),
      k.map("f", "fn", "shift").to("6", "shift"),
      k.map("x", "fn", "shift").to("7", "shift"),
      k.map("c", "fn", "shift").to("8", "shift"),
      k.map("v", "fn", "shift").to("9", "shift"),
      k.map("spacebar", "fn", "shift").to("0", "shift"),
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
