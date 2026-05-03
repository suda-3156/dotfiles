import * as k from "karabiner_ts"

const PROFILE_NAME = "Default profile"

// toggle app
// osascript -e 'id of app "Ghostty"' to get the bundle identifier
// const toggle_app = (app_name: string, bundle_id: string, event: k.FromEvent) => {
// 	return k.duoLayer(";", "spacebar").manipulators([
// 		k
// 			.map(event)
// 			.to({
// 				shell_command: `osascript -e 'tell application "System Events" to set visible of application process "${app_name}" to false'`,
// 			})
// 			.condition(k.ifApp(bundle_id)),
// 		k
// 			.map(event)
// 			.to({
// 				shell_command: `osascript -e 'tell application "${app_name}" to activate'`,
// 			})
// 			.condition(k.ifApp(bundle_id).unless()),
// 	])
// }

const applications = [
	k
		.rule("Quit application by double tapping command-q")
		.manipulators([k.mapDoubleTap("q", "command").delay(300).to("q", "command").singleTap(null)]),

	// toggle_app("Arc", "^company\\.thebrowser\\.Browser$", { key_code: "w" }),
	// toggle_app("Ghostty", "^com\\.mitchellh\\.ghostty$", { key_code: "e" }),
	// toggle_app("WezTerm", "^com.github\\.wez\\.wezterm$", { key_code: "r" }),
]

const hyperkey = [
	k.rule("Remap Caps Lock to Ctrl when held, Esc when tapped").manipulators([
		k
			.map({ key_code: "caps_lock", modifiers: { optional: ["any"] } })
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
]

// From: https://ryoppippi.com/blog/2024-10-19
const imkit = [
	k.rule("Tap CMD to toggle Kana/Eisuu").manipulators([
		k
			.map({ key_code: "left_command", modifiers: { optional: ["any"] } })
			.to({ key_code: "left_command", lazy: true })
			.toIfAlone({ key_code: "japanese_eisuu" })
			.parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 }),
		k
			.map({
				key_code: "semicolon",
				modifiers: { mandatory: ["right_command"] },
			})
			.to({ key_code: "japanese_kana" }),
	]),
]

const rcmd_number = [
	k.rule("right_command + wersdfxcv, space bar => 1 ~ 0").manipulators([
		k
			.map({ key_code: "w", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("1"),
		k
			.map({ key_code: "e", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("2"),
		k
			.map({ key_code: "r", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("3"),
		k
			.map({ key_code: "s", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("4"),
		k
			.map({ key_code: "d", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("5"),
		k
			.map({ key_code: "f", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("6"),
		k
			.map({ key_code: "x", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("7"),
		k
			.map({ key_code: "c", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("8"),
		k
			.map({ key_code: "v", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
			.to("9"),
		k
			.map({
				key_code: "spacebar",
				modifiers: { mandatory: ["right_command"], optional: ["shift"] },
			})
			.to("0"),
	]),

	k
		.rule("right_command + jkl => `-=")
		.manipulators([
			k
				.map({ key_code: "j", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
				.to("grave_accent_and_tilde"),
			k
				.map({ key_code: "k", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
				.to("hyphen"),
			k
				.map({ key_code: "l", modifiers: { mandatory: ["right_command"], optional: ["shift"] } })
				.to("equal_sign"),
		]),
]

const volume_brightness = [
	k
		.rule("right_command + arrows => volume + brightness")
		.manipulators([
			k.map("up_arrow", "right_command").to("volume_increment"),
			k.map("down_arrow", "right_command").to("volume_decrement"),
			k.map("left_arrow", "right_command").to("display_brightness_decrement"),
			k.map("right_arrow", "right_command").to("display_brightness_increment"),
		]),
]

k.writeToProfile(PROFILE_NAME, [
	...applications,
	...hyperkey,
	...imkit,
	...rcmd_number,
	...volume_brightness,
])

k.writeToGlobal({
	show_in_menu_bar: false,
})
