import * as k from "karabiner_ts";

// Rules to open and close applications
export const applicationRules = [
  k
    .rule("Quit application by double tapping command-q")
    .manipulators([
      k
        .mapDoubleTap("q", "command")
        .delay(200)
        .to("q", "command")
        .singleTap(null),
    ]),

  // From: https://zenn.dev/kawarimidoll/articles/753e9987863f6e
  k
    .rule(
      "cmd + . to open current Finder directory in Ghostty",
      k.ifApp("^com\\.apple\\.finder$"),
    )
    .manipulators([
      k
        .map({ key_code: "period", modifiers: { mandatory: ["left_command"] } })
        .to({
          shell_command:
            "osascript ~/dotfiles/extras/karabiner/script/open_cwd_ghostty.applescript",
        }),
    ]),
];
