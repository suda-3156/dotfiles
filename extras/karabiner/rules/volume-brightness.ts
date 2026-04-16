import * as k from "karabiner_ts";

export const volumeBrightnessRules = [
  k
    .rule("right_command + arrows => volume + brightness")
    .manipulators([
      k.map("up_arrow", "right_command").to("volume_increment"),
      k.map("down_arrow", "right_command").to("volume_decrement"),
      k.map("left_arrow", "right_command").to("display_brightness_decrement"),
      k.map("right_arrow", "right_command").to("display_brightness_increment"),
    ]),
];
