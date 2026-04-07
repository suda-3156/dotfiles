import * as k from "karabiner_ts";

export const volumeBrightnessRules = [
  k
    .rule("fn + arrows => volume + brightness")
    .manipulators([
      k.map("up_arrow", "fn").to("volume_increment"),
      k.map("down_arrow", "fn").to("volume_decrement"),
      k.map("left_arrow", "fn").to("display_brightness_decrement"),
      k.map("right_arrow", "fn").to("display_brightness_increment"),
    ]),
];
