-- -----------------------------------
-- -------- Bluetooth
-- -----------------------------------
-- sbar.add("event", "bluetooth_on",  "IOBluetoothHostControllerPoweredOnNotification")
-- sbar.add("event", "bluetooth_off", "IOBluetoothHostControllerPoweredOffNotification")
-- sbar.add("event", "bluetooth_status", "com.apple.bluetooth.status")


-- -----------------------------------
-- -------- Yabai
-- -----------------------------------
sbar.add("event", "yabai_loaded")
sbar.add("event", "yabai_window_created")
sbar.add("event", "yabai_window_moved")
sbar.add("event", "yabai_window_focused")
sbar.add("event", "yabai_window_resized")
sbar.add("event", "yabai_application_visible")


-- -----------------------------------
-- -------- Skhd
-- -----------------------------------
sbar.add("event", "skhd_space_type_changed")
sbar.add("event", "skhd_window_type_changed")


-- -----------------------------------
-- -------- Custom
-- -----------------------------------
sbar.add("event", "swap_menus_and_spaces")
