-- =============================================
-- ========== Config
-- =============================================
local apple_config = {
	position = "left",
	icon = {
		string = icons.aqi,
		font = { style = "Black", size = 25.0 },
		color = colors.stardust,
		background = { color = colors.almost_transparent },
	},
	label = { drawing = false },
	padding_left = settings.item_padding,
	padding_right = 5,
	y_offset = 2,

	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
}

-- =============================================
-- ========== Setup
-- =============================================
local apple = sbar.add("item", "apple", apple_config)
