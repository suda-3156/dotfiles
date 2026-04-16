import * as k from "karabiner_ts";

// toggle app
// osascript -e 'id of app "Ghostty"' to get the bundle identifier
// const toggle_app = (
//   app_name: string,
//   bundle_id: string,
//   event: k.FromEvent,
// ) => {
//   return k.duoLayer(";", "spacebar").manipulators([
//     k
//       .map(event)
//       .to({
//         shell_command: `osascript -e 'tell application "System Events" to set visible of application process "${app_name}" to false'`,
//       })
//       .condition(k.ifApp(bundle_id)),
//     k
//       .map(event)
//       .to({
//         shell_command: `osascript -e 'tell application "${app_name}" to activate'`,
//       })
//       .condition(k.ifApp(bundle_id).unless()),
//   ]);
// };

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
  // k
  //   .rule(
  //     "cmd + . to open current Finder directory in Ghostty",
  //     k.ifApp("^com\\.apple\\.finder$"),
  //   )
  //   .manipulators([
  //     k
  //       .map({ key_code: "period", modifiers: { mandatory: ["left_command"] } })
  //       .to({
  //         shell_command:
  //           "osascript ~/dotfiles/extras/karabiner/script/open_cwd_ghostty.applescript",
  //       }),
  //   ]),

  // toggle_app("Arc", "^company\\.thebrowser\\.Browser$", { key_code: "w" }),
  // toggle_app("Ghostty", "^com\\.mitchellh\\.ghostty$", { key_code: "e" }),
  // toggle_app("WezTerm", "^com.github\\.wez\\.wezterm$", { key_code: "r" }),
];
