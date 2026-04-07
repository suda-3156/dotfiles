import * as k from "karabiner_ts";

export type SimpleModification = {
  from: { key_code: string } | { apple_vendor_top_case_key_code: string };
  to: Array<
    { key_code: string } | { apple_vendor_top_case_key_code: string }
  >;
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
