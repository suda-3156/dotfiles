// From: https://github.com/kawarimidoll/dotfiles/blob/master/karabiner/karabiner.ts
import * as k from "karabiner_ts";
import { fnNumbersRules } from "./rules/fn-numbers.ts";
import { holdCmdQRules } from "./rules/hold-cmd-q.ts";
import { volumeBrightnessRules } from "./rules/volume-brightness.ts";
import { capsTabHyperRules } from "./rules/caps-tab-hyper.ts";
import { imkitRules } from "./rules/imkit.ts";
import { appRules } from "./rules/app.ts";
import {
  type ExtendedProfile,
  APPLE_INTERNAL_KEYBOARD,
  KEYCHRON_K7_PRO,
  applySimpleModifications,
  rightCmdToFn,
} from "./simple-modifications.ts";

const PROFILE_NAME = "Default profile";

// Write complex modifications
k.writeToProfile(PROFILE_NAME, [
  ...volumeBrightnessRules,
  ...holdCmdQRules,
  ...fnNumbersRules,
  ...capsTabHyperRules,
  ...imkitRules,
  ...appRules,
]);

// Write global settings
k.writeToGlobal({
  show_in_menu_bar: false,
});

// Read and update config with simple modifications and some parameters
const configPath = [
  Deno.env.get("HOME")!,
  ".config",
  "karabiner",
  "karabiner.json",
].join("/");

const config = JSON.parse(
  Deno.readTextFileSync(configPath),
) as k.KarabinerConfig;

const profile = config?.profiles.find(
  (v) => v.name === PROFILE_NAME,
)! as ExtendedProfile;

if (!profile) {
  console.error(`Profile ${PROFILE_NAME} not found`);
  Deno.exit(1);
}

// Set profile parameters
profile.parameters = {
  delay_milliseconds_before_open_device: 1000,
};

// Set complex modifications parameters
profile.complex_modifications.parameters = {
  "basic.simultaneous_threshold_milliseconds": 50,
  "basic.to_delayed_action_delay_milliseconds": 500,
  "basic.to_if_alone_timeout_milliseconds": 200,
  "basic.to_if_held_down_threshold_milliseconds": 200,
};

// Set virtual HID keyboard settings
profile.virtual_hid_keyboard = {
  country_code: 0,
  indicate_sticky_modifier_keys_state: true,
  keyboard_type_v2: "ansi",
};

// Apply simple modifications to devices
applySimpleModifications(profile, APPLE_INTERNAL_KEYBOARD, rightCmdToFn);
applySimpleModifications(profile, KEYCHRON_K7_PRO, rightCmdToFn);

// Write back to file
const json = JSON.stringify(config, null, 2);
Deno.writeTextFile(configPath, json).catch((err) => {
  console.error(err);
  Deno.exit(1);
});

console.log(`✓ Profile ${PROFILE_NAME} updated with all settings.`);
