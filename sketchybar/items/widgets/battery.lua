-- =============================================
-- ========== Config
-- =============================================
local battery_config = {
  position = "right",
  update_freq = 60,
  icon = {
    string = icons.battery._0,
    font = { style = "Medium", size = 17.5 },
  },
  label = {
    string = "??%",
    font = { family = settings.font.numbers, style = "Semibold", size = 12.0 },
  },
}



-- =============================================
-- ========== Setup
-- =============================================
local battery = sbar.add("item", "widgets.battery", battery_config)
-- Padding
sbar.add("item", "widgets.battery.padding", { position = "right", width = settings.group_padding })



-- =============================================
-- ========== Functions
-- =============================================

---Update battery information
---@param env table Environment variables.
local function update_battery_info(env)
  ---@param batt_info string
  sbar.exec("pmset -g batt", function(batt_info)
    local icon, label, color = icons.battery._0, "??%", colors.battery.health

    local charging = batt_info:find("AC Power") ~= nil
    local found, _, percent = batt_info:find("(%d+)%%")
    if found then percent = tonumber(percent); label = ("%d%%"):format(percent) end

    if charging then icon = icons.battery.charging
    elseif found then
      if percent >= 85 then icon = icons.battery._100
      elseif percent > 60 then icon = icons.battery._75; color = colors.battery.normal
      elseif percent > 35 then icon = icons.battery._50; color = colors.battery.normal
      elseif percent > 15 then icon = icons.battery._25; color = colors.battery.death
      else icon = icons.battery._0; color = colors.battery.death
      end
    else icon = icons.battery._0; color = colors.battery.death
    end

    battery:set({ icon = { string = icon, color = color }, label = { string = label, color = color } })
  end)
end



-- =============================================
-- ========== Listeners
-- =============================================
-- routine, system_woke, power_source_change: Update battery info.
battery:subscribe({ "routine", "system_woke", "power_source_change" }, update_battery_info)
