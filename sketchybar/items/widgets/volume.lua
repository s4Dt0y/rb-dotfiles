-- =============================================
-- ========== General
-- =============================================
local popup_width = 150
local percent_width = { full = 35, regular = 30 }



-- =============================================
-- ========== Config
-- =============================================
local volume_percent_config = {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "??%",
    font = { family = settings.font.numbers, style = "Bold", size = 12.0 },
    color = colors.magenta,
    padding_left = settings.item_padding,
    width = percent_width.regular,
  },
}


local volume_icon_config = {
  position = "right",
  icon = {
    string = icons.volume._100,
    font = { style = "Black", size = 12.5 },
    color = colors.with_alpha(colors.magenta, 0.50),
    width = 0,
  },
  label = {
    string = icons.volume.error,
    font = { style = "Black", size = 12.5 },
    color = colors.magenta,
    width = 25,
    align = "left",
  },
}


local volume_slider_config = {
  position = "popup.widgets.volume.bracket",
  slider = {
    knob = { drawing = true, string = "􀀁" },
    background = {
      height = 12,
      corner_radius = 50,
      color = colors.with_alpha(colors.gray, 0.5),
    },
    highlight_color = colors.magenta,
  },
  background = { color = colors.gray, height = 2, y_offset = -16 },  -- Divider
  click_script = [[osascript -e "set volume output volume $PERCENTAGE"]],
}



-- =============================================
-- ========== Setup
-- =============================================
local volume_percent = sbar.add("item", "widgets.volume.percent", volume_percent_config)
local volume_icon    = sbar.add("item", "widgets.volume.icon", volume_icon_config)
local volume_bracket = sbar.add("bracket", "widgets.volume.bracket", { volume_icon.name, volume_percent.name }, { popup = { align = "center" } })
local volume_slider  = sbar.add("slider", popup_width, volume_slider_config)
sbar.add("item", "widgets.volume.padding", { position = "right", width = settings.group_padding })



-- =============================================
-- ========== Functions
-- =============================================
local function change_volume(env)
  local volume, icon = tonumber(env.INFO), icons.volume.error
  if volume > 66 then icon = icons.volume._100
  elseif volume > 33 then icon = icons.volume._66
  elseif volume > 10 then icon = icons.volume._33
  else icon = icons.volume._10
  end

  volume_icon:set({ label = icon })
  volume_percent:set({
    label = {
      string = ("%2d%%"):format(volume),
      width = volume == 100 and percent_width.full or percent_width.regular,
    },
  })
  volume_slider:set({ slider = { percentage = volume } })
end


local function collapse_volume_details(env)
  local drawing = volume_bracket:query().popup.drawing == "on"
  if not drawing then return end
  volume_bracket:set({ popup = { drawing = false } })
  sbar.remove("/volume.device\\.*/")
end


local function expand_volume_details(env)
  volume_bracket:set({ popup = { drawing = true } })

  local current_audio_device = "None"
  sbar.exec("SwitchAudioSource -t output -c", function(result)
    current_audio_device = result:sub(1, -2)
    sbar.exec("SwitchAudioSource -t output -a", function(available)
      local counter = 0
      for device in string.gmatch(available, "[^\r\n]+") do
        local color = current_audio_device == device and colors.white or colors.gray
        local device_config = {
          position = ("popup.%s"):format(volume_bracket.name),
          click_script = ([[SwitchAudioSource -s "%s" && sketchybar --set /volume.device\\.*/ label.color=%s --set $NAME label.color=%s]]):format(device, colors.gray, colors.white),
          label = { string = device, color = color },
          width = popup_width,
          align = "center",
        }
        sbar.add("item", "volume.device." .. counter, device_config)
        counter = counter + 1
      end
    end)
  end)
end


local function toggle_volume_details(env)
  local should_draw = volume_bracket:query().popup.drawing == "off"
  if should_draw then expand_volume_details(env)
  else collapse_volume_details(env)
  end
end


local function click_volume(env)
  if env.BUTTON == "right" then sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
  else toggle_volume_details(env)
  end
end



-- =============================================
-- ========== Listeners
-- =============================================
volume_bracket:subscribe("volume_change", change_volume)
-- BUG: Cannot subscribe "mouse.clicked" on `volume_bracket`. (No effect)
volume_icon:subscribe("mouse.clicked", click_volume)
volume_percent:subscribe("mouse.clicked", click_volume)
volume_bracket:subscribe("mouse.exited.global", collapse_volume_details)
