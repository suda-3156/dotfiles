import * as k from "karabiner_ts";

// From: https://ryoppippi.com/blog/2024-10-19
export const imkitRules = [
  k.rule("Tap CMD to toggle Kana/Eisuu").manipulators([
    k
      .map({ key_code: "left_command", modifiers: { optional: ["any"] } })
      .to({ key_code: "left_command", lazy: true })
      .toIfAlone({ key_code: "japanese_eisuu" })
      .description(`Tap left_command alone to switch to japanese_eisuu`)
      .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 }),
    k
      .map({ key_code: "right_command", modifiers: { optional: ["any"] } })
      .to({ key_code: "right_command", lazy: true })
      .toIfAlone({ key_code: "japanese_kana" })
      .description(`Tap right_command alone to switch to japanese_kana`)
      .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 }),
  ]),
];
