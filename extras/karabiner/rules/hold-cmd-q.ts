import * as k from "karabiner_ts";

// From: https://github.com/ryoppippi/dotfiles/blob/f598b5fc7291ce4d46899d3431a3f6283e062b24/karabiner/karabiner.ts#L24-L35
export const holdCmdQRules = [
  k.rule("Quit application by holding command-q").manipulators([
    k
      .map({
        key_code: "q",
        modifiers: { mandatory: ["command"], optional: ["caps_lock"] },
      })
      .toIfHeldDown({
        key_code: "q",
        modifiers: ["command"],
        repeat: false,
      }),
  ]),
];
