-- -----------------------------------
-- -------- Group1
-- -----------------------------------
sbar.add("item", "widgets.group1.padding", { position = "right", width = 2 * settings.group_padding })
require("items.widgets.battery")
require("items.widgets.volume")
require("items.widgets.surge")
local braket_config = { background = { color = colors.with_alpha(colors.gray, 0.20) } }
sbar.add("bracket", "widgets.group1", { "widgets.group1.padding", "widgets.battery", "widgets.volume.bracket", "Surge" }, braket_config)


-- -----------------------------------
-- -------- Group2
-- -----------------------------------
sbar.add("item", "widgets.group2.padding", { position = "right", width = 2 * settings.group_padding })
require("items.widgets.app")
sbar.add("bracket", "widgets.group2", { "widgets.group2.padding", "app.qq", "app.wechat", "app.mail" }, braket_config)
