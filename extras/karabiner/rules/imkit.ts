import * as k from "karabiner_ts";

export const imkitRules = [
  k.rule("Tap CMD to toggle Kana/Eisuu").manipulators([
    k
      .map({ key_code: "left_command", modifiers: { optional: ["any"] } })
      .to({ key_code: "left_command", lazy: true })
      .toIfAlone({ key_code: "japanese_eisuu" })
      .description(`Tap left_command alone to switch to japanese_eisuu`)
      .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 }),
    k
      .map({ key_code: "fn", modifiers: { optional: ["any"] } })
      .to({ key_code: "fn", lazy: true })
      .toIfAlone({ key_code: "japanese_kana" })
      .description(`Tap fn alone to switch to japanese_kana`)
      .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 }),
  ]),
];
