-- =============================================
-- ========== Helper
-- =============================================
-- Run the clock binary to update the clock.
sbar.exec("killall clock &> /dev/null; $CONFIG_DIR/helpers/event_providers/clock/bin/clock clock_update 1.0")



-- =============================================
-- ========== Config
-- =============================================
local calendar_config = {
  position = "right",
  icon = {
    font = { style = "Heavy", size = 13.0 },
    color = colors.orange,
  },
  label = {
    font = { family = settings.font.numbers, style = "Bold", size = 13.5 },
    color = colors.cyan,
    padding_left  = 6,
    padding_right = 0,
    width = 73,
    align = "left",
  },
}



-- =============================================
-- ========== Setup
-- =============================================
local calendar = sbar.add("item", "calendar", calendar_config)
-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_padding })



-- =============================================
-- ========== Listeners
-- =============================================
-- forced: Update the calender and clock.
calendar:subscribe({ "forced" }, function(env) calendar:set({ icon = os.date(("%s %s %s"):format(icons.calendar, os.date("%a %b"), tonumber(os.date("%d")))), label = "Loading..." }) end)
-- system_woke: Update the calender.
calendar:subscribe({ "system_woke" }, function(env) calendar:set({ icon = os.date(("%s %s %s"):format(icons.calendar, os.date("%a %b"), tonumber(os.date("%d")))) }) end)
-- clock_update: Update the clock.
calendar:subscribe({ "clock_update" }, function(env) calendar:set({ label = env.time }) end)
