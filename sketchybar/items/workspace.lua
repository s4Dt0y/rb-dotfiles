local colors = require("colors")
local settings = require("settings")

sbar.add("event", "aerospace_workspace_change")

local current_workspace = sbar.add("item", {
	label = { font = { family = settings.font.mono }, padding_right = 12, string = "1" },
	background = {
		color = colors.bg2,
		border_color = colors.black,
		border_width = 3,
	},
})

current_workspace:subscribe("aerospace_workspace_change", function(env)
	current_workspace:set({ label = { string = env.FOCUSED_WORKSPACE } })
end)
