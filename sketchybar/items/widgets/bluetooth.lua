-- NOTE: Not used.
-- =============================================
-- ========== Config
-- =============================================
local bluetooth_config = {
  position = "right",
  icon = {
    string = icons.bluetooth.item,
    font = { family = settings.font.nerd_font, style = "Bold", size = 14.0 },
    color = colors.blue,
  },
  label = {
    string = "?",
    font = { family = settings.font.nerd_font, style = "Bold", size = 14.0 },
    color = colors.blue,
  },
  background = { color = colors.almost_transparent }
}



-- =============================================
-- ========== Setup
-- =============================================
local bluetooth = sbar.add("item", "widgets.bluetooth", bluetooth_config)
sbar.add("item", "widgets.bluetooth.padding", { position = "right", width = settings.group_padding })



-- =============================================
-- ========== Functions
-- =============================================
local function update_bluetooth_status(env)
  sbar.exec("blueutil -p", function(result)
    local bluetooth_on = tonumber(result) == 1
    local label = bluetooth_on and icons.bluetooth.on or icons.bluetooth.off
    bluetooth:set({ label = label })
  end)
end


local function click_bluetooth(env)
  if env.BUTTON == 'left' then
    sbar.exec("blueutil -p", function(result)
      local bluetooth_status = tonumber(result)
      sbar.exec(("blueutil --power %d"):format(1 - bluetooth_status))
    end)
  elseif env.BUTTON == 'right' then sbar.exec([[open "/System/Library/PreferencePanes/Bluetooth.prefPane"]])
  end
end



-- =============================================
-- ========== Listeners
-- =============================================
-- forced, bluetooth_status: Update bluetooth status.
bluetooth:subscribe({ "forced", "bluetooth_status" }, update_bluetooth_status)
-- mouse.clicked: Toggle bluetooth status or open bluetooth preference pane.
bluetooth:subscribe("mouse.clicked", click_bluetooth)
