-- =============================================
-- ========== Config
-- =============================================
local messages_config = {
	position = "right",
	click_script = "open -a 'Messages'",
	padding_left = 2 * settings.group_padding,
	padding_right = settings.item_padding,
	icon = {
		string = icons.app.messages,
		font = { family = settings.font.nerd_font, style = "Regular", size = 16.0 },
		color = colors.app.discord,
		padding_right = 1,
	},
	label = {
		string = "X",
		font = { style = "Medium", size = 13.0 },
		color = colors.white,
		padding_left = 0,
	},
	background = { color = colors.almost_transparent },
}

local mail_config = {
	position = "right",
	click_script = "open -a 'Mailspring'",
	padding_left = 2 * settings.group_padding,
	padding_right = settings.item_padding,
	icon = {
		string = icons.app.mail,
		font = { family = settings.font.nerd_font, style = "Regular", size = 17.0 },
		color = colors.app.discord,
		padding_right = 2,
	},
	label = {
		string = "?",
		font = { style = "Medium", size = 13.0 },
		color = colors.white,
		padding_left = 0,
	},
	background = { color = colors.almost_transparent },
}

local discord_config = {
	position = "right",
	click_script = "open -a 'Discord'",
	padding_left = 2 * settings.group_padding,
	padding_right = settings.item_padding,
	icon = {
		string = icons.app.discord,
		font = { family = settings.font.nerd_font, style = "Regular", size = 16.0 },
		color = colors.app.discord,
		padding_right = 1,
	},
	label = {
		string = "?",
		font = { style = "Medium", size = 13.0 },
		color = colors.white,
		padding_left = 0,
	},
	background = { color = colors.almost_transparent },
}

-- =============================================
-- ========== Setup
-- =============================================
local messages = sbar.add("item", "app.messages", messages_config)
local discord = sbar.add("item", "app.discord", discord_config)
local mail = sbar.add("item", "app.mail", mail_config)

local event_listener = sbar.add("item", "app.event_listener", { drawing = false, updates = true, update_freq = 30 })

-- =============================================
-- ========== Functions
-- =============================================
local function update_app_status(env)
	local app_list = {
		["messages"] = "com.app.messages",
		["mail"] = "com.mailspring.mailspring",
		["discord"] = "com.hnc.Discord",
	}
	for app_name, app_bundle_id in pairs(app_list) do
		sbar.exec(([[lsappinfo info -only StatusLabel "%s"]]):format(app_bundle_id), function(result)
			-- local label = result:sub(1, -2)
			local label = result:match("%d+") or "0"
			sbar.set(("app.%s"):format(app_name), { label = label })
		end)
	end
end

-- =============================================
-- ========== Listeners
-- =============================================
event_listener:subscribe({ "forced", "routine" }, update_app_status)
