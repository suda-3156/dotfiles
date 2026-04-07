import * as k from "karabiner_ts";

export const capsTabHyperRules = [
  k
    .rule("Remap Caps Lock to Ctrl when held, Esc when tapped")
    .manipulators([
      k
        .map("caps_lock")
        .toIfAlone("escape")
        .to({ key_code: "left_control", lazy: true }),
    ]),
  k
    .layer("tab", "hyper")
    .manipulators([
      k.map("k").to("up_arrow"),
      k.map("j").to("down_arrow"),
      k.map("l").to("right_arrow"),
      k.map("h").to("left_arrow"),
      k.map("spacebar").to("delete_or_backspace"),
      k.map("d").to("delete_or_backspace"),
      k.map("semicolon").to("escape"),
    ]),
];
