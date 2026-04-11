import * as k from "karabiner_ts";

export const appRules = [
  // From: https://zenn.dev/kawarimidoll/articles/753e9987863f6e
  k
    .rule(
      "⌘. to open current Finder directory in Ghostty",
      k.ifApp("^com\\.apple\\.finder$"),
    )
    .manipulators([
      k
        .map({ key_code: "period", modifiers: { mandatory: ["left_command"] } })
        .to({
          shell_command:
            "osascript -e 'tell application \"Finder\" to set cwd to POSIX path of (target of front window as alias)' -e 'tell application \"Ghostty\"' -e 'activate' -e 'set conf to new surface configuration' -e 'set initial working directory of conf to cwd' -e 'new window with configuration conf' -e 'end tell'",
        }),
    ]),
];
