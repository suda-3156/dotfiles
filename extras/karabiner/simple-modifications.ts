// From: https://github.com/kawarimidoll/dotfiles/blob/6e1a495bd066e5be079933e1c896ae3416366e30/karabiner/karabiner.ts#L8-L50
import * as k from "karabiner_ts";

export type SimpleModification = {
  from: { key_code: string } | { apple_vendor_top_case_key_code: string };
  to: Array<{ key_code: string } | { apple_vendor_top_case_key_code: string }>;
};

export type DeviceWithSimpleModifications = {
  identifiers: k.DeviceIdentifier;
  simple_modifications: SimpleModification[];
  ignore?: boolean;
};

export type ExtendedProfile = k.KarabinerProfile & {
  devices?: DeviceWithSimpleModifications[];
  simple_modifications?: SimpleModification[];
  parameters?: {
    delay_milliseconds_before_open_device?: number;
  };
  virtual_hid_keyboard?: {
    country_code?: number;
    indicate_sticky_modifier_keys_state?: boolean;
    keyboard_type_v2?: string;
  };
};

// Helper function to create simple modifications
export function simpleModifications(
  params: {
    from: Parameters<typeof k.getKeyWithAlias>[0];
    to:
      | Parameters<typeof k.getKeyWithAlias>[0]
      | { apple_vendor_top_case_key_code: string };
  }[],
): SimpleModification[] {
  return params.map((p) => {
    const from = k.getKeyWithAlias(p.from);
    if (typeof p.to === "object" && "apple_vendor_top_case_key_code" in p.to) {
      return {
        from: { key_code: from },
        to: [p.to],
      };
    }
    const to = k.getKeyWithAlias(
      p.to as Parameters<typeof k.getKeyWithAlias>[0],
    );
    return { from: { key_code: from }, to: [{ key_code: to }] };
  });
}

// Helper function to apply simple modifications to a device
export function applySimpleModifications(
  profile: ExtendedProfile,
  identifiers: k.DeviceIdentifier,
  simple_modifications: SimpleModification[],
) {
  const targetDevice = profile.devices?.find(
    (d) =>
      d.identifiers.is_keyboard === identifiers.is_keyboard &&
      (identifiers.vendor_id === undefined ||
        d.identifiers.vendor_id === identifiers.vendor_id) &&
      (identifiers.product_id === undefined ||
        d.identifiers.product_id === identifiers.product_id),
  );

  if (targetDevice) {
    targetDevice.simple_modifications = simple_modifications;
  } else {
    profile.devices = [
      ...(profile.devices || []),
      { identifiers, simple_modifications },
    ];
  }
}

// Device identifiers
export const APPLE_INTERNAL_KEYBOARD = {
  is_keyboard: true,
} as const satisfies k.DeviceIdentifier;

export const KEYCHRON_K7_PRO = {
  product_id: 624,
  vendor_id: 13364,
  is_keyboard: true,
} as const satisfies k.DeviceIdentifier;

// Simple modification definitions
// Replace keys right next to the space bar to fn keys
export const rightCmdToFn = simpleModifications([
  { from: "r⌘", to: { apple_vendor_top_case_key_code: "keyboard_fn" } },
]);

export const rightCtrlToFn = simpleModifications([
  { from: "r⌃", to: { apple_vendor_top_case_key_code: "keyboard_fn" } },
]);

export const rightOptToFn = simpleModifications([
  { from: "r⌥", to: { apple_vendor_top_case_key_code: "keyboard_fn" } },
]);
