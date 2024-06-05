-- =============================================
-- ========== General
-- =============================================
local app_icons = require("helpers.app_icons")
local space_icons = { "􀀺", "􀀼", "􀀾", "􀁀", "􀁂", "􀁄", "􀁆", "􀁈", "􀁊", "􀓵" }

local spaces       = {}  -- Used to store space items.
local space_popups = {}  -- Used to store space popup items.



-- =============================================
-- ========== Config
-- =============================================
local function _get_space_name(index) return ("space.%s"):format(index) end

-- -----------------------------------
-- -------- Space
-- -----------------------------------
local space_config = {}
local space_popup_config = {}
for i = 1, 10, 1 do
  space_config[i] = {
    space = i,
    icon = {
      string = space_icons[i],
      color = colors.status.inactive,
      highlight_color = colors.status.active,
      padding_left  = 12,
      padding_right = 5,
    },
    label = {
      font = "sketchybar-app-font:Regular:16.0",
      color = colors.inactive,
      highlight_color = colors.status.active,
      padding_right = 15,
    },
    background = { color = colors.red, height = 26 },
  }

  space_popup_config[i] = {
    position = ("popup.%s"):format(_get_space_name(i)),
    padding_left  = 1,
    padding_right = 0,
    background = { drawing = true, image = { corner_radius = 10, scale = 0.15 } },
  }
end


-- -----------------------------------
-- -------- Space Window Observer
-- -----------------------------------
local space_window_observer_config = { drawing = false, updates = true }


-- -----------------------------------
-- -------- Space Indicator
-- -----------------------------------
local space_indicator_config = {
  position = "left",
  display = "active",
  -- padding_left  = -4 * settings.group_padding,
  padding_right = 3 * settings.group_padding,
  icon  = {
    string = icons.switch.on,
    font = { style = "Bold", size = 16.0 },
    color  = colors.stardust,
    padding_left = 2 * settings.group_padding,
  },
  label = {
    string = "Menus",
    font = { style = "SemiBold", size = 12.0 },
    color = colors.status.active,
    padding_left  = 2 * settings.group_padding,
    padding_right = 3 * settings.group_padding,
    y_offset = 1,
    width = 0,
  },
}



-- =============================================
-- ========== Setup
-- =============================================
-- Space Items
for i = 1, 10, 1 do
  local space = sbar.add("space", _get_space_name(i), space_config[i])
  local space_popup = sbar.add("item", ("%s.popup"):format(_get_space_name(i)), space_popup_config[i])
  spaces[i], space_popups[i] = space, space_popup

  -- Add padding between space items.
  -- NOTE: Use add `space` to avoid extra paddings.
  -- sbar.add("item", ("space.%s.padding"):format(i), { position = "left", width = settings.group_padding })
  sbar.add("space", ("space.%s.padding"):format(i), { space = i, width = settings.group_padding })
end

-- Space Window Observer
local space_window_observer = sbar.add("item", space_window_observer_config)

-- Space Indicator
local space_indicator = sbar.add("item", space_indicator_config)



-- =============================================
-- ========== Functions
-- =============================================
-- -----------------------------------
-- -------- Space
-- -----------------------------------

---Set space properties based on its type.
---@param env table Environment variables.
local function update_space(env)
  --- Get space and selected status.
  assert(env.SID ~= nil, "SID is nil")
  local space_id = tonumber(env.SID)
  local space = spaces[space_id]
  local selected = env.SELECTED == "true"

  --- Set space properties.
  if selected then
    -- CASE 1: Space is selected.
    sbar.exec("yabai -m query --spaces --space | jq -r '.type'", function(result)
      local space_type = result:sub(1, -2)
      local space_color = colors.yabai[space_type] or colors.yabai.error
      sbar.animate("tanh", 5, function() space:set({ icon = { highlight = selected }, label = { highlight = selected }, background = { color = space_color } }) end)
    end)
  else  -- CASE 2: Space is not selected.
    sbar.animate("tanh", 5, function() space:set({ icon = { highlight = selected }, label = { highlight = selected }, background = { color = colors.almost_transparent } }) end)
  end
end


---Update app icons in space.
---@param env table Environment variables.
local function update_space_app(env)
  local icon_line = ""
  local no_app = true
  for app, count in pairs(env.INFO.apps) do
    if app ~= "GrabIt" and app ~= "HSTracker" then
      no_app = false
      local icon = app_icons[app] or app_icons["Default"]
      icon_line = icon_line .. icon
    end
  end

  if no_app then icon_line = "—" end
  sbar.animate("tanh", 10, function() spaces[env.INFO.space]:set({ label = icon_line }) end)
end


---Click space event.
---`cmd + left`: Show space thumbnail.
---`left / right`: Focus/Destroy space.
---@param env table Environment variables.
local function click_space(env)
  --- Get space and selected status.
  assert(env.SID ~= nil, "SID is nil")
  local space_id = tonumber(env.SID)
  local space, space_popup = spaces[space_id], space_popups[space_id]

  -- CASE 1: Show space thumbnail.
  if env.MODIFIER == "cmd" and env.BUTTON == "left" then
    space:set({ popup = { drawing = "toggle" } })
    space_popup:set({ background = { image = "space." .. env.SID } })
  else -- CASE 2: Focus or Destroy space.
    local op = env.BUTTON == "left" and "--focus" or "--destroy"
    sbar.exec(("yabai -m space %s %s"):format(op, env.SID))
  end
end


-- -----------------------------------
-- -------- Triggers
-- -----------------------------------

---Trigger `space_windows_change` event.
---@param env table Environment variables.
local function trigger_space_windows_change_event(env)
  local selected = env.SELECTED == "true"
  if selected then sbar.trigger("space_windows_change") end
end


---Trigger `swap_menus_and_spaces` event.
---@param env table Environment variables.
local function trigger_swap_menus_and_spaces_event(env) sbar.trigger("swap_menus_and_spaces") end


-- -----------------------------------
-- -------- Space Indicator
-- -----------------------------------

---Expand space indicator.
---@param env table Environment variables.
local function expand_indicator(env)
  sbar.animate("tanh", 30, function()
    space_indicator:set({
      background = { color = colors.stardust, border_color = { alpha = 1.0 } },
      icon = { color = colors.status.active },
      label = { width = "dynamic" },
    })
  end)
end


---Collapse space indicator.
---@param env table Environment variables.
local function collapse_indicator(env)
  sbar.animate("tanh", 30, function()
    space_indicator:set({ background = { color = colors.almost_transparent }, icon = { color = colors.stardust }, label = { width = 0 } })
  end)
end


---Toggle space indicator.
---@param env table Environment variables.
local function toggle_indicator(env)
  local currently_on = space_indicator:query().icon.value == icons.switch.on
  space_indicator:set({ icon = currently_on and icons.switch.off or icons.switch.on, label = currently_on and "Spaces" or "Menus" } )
end



-- =============================================
-- ========== Listeners
-- =============================================
-- -----------------------------------
-- -------- Space
-- -----------------------------------
for i = 1, 10, 1 do
  local space = spaces[i]

  -- space_change, skhd_space_type_changed, yabai_loaded: Update space.
  space:subscribe({ "forced", "space_change", "skhd_space_type_changed", "yabai_loaded" }, update_space)
  -- mouse.clicked: Trigger click space funtion.
  space:subscribe("mouse.clicked", click_space)
  -- mouse.exited: Hide space thumbnail.
  space:subscribe("mouse.exited", function(env) space:set({ popup = { drawing = false } }) end)
end


-- -----------------------------------
-- -------- Space Window Observer
-- -----------------------------------
-- NOTE: Sketchybar does not capture all windows, the `yabai_window_created` and `yabai_application_visable` events are used for additional cases.
-- yabai_window_created, yabai_application_visable: Update app icons in space.
space_window_observer:subscribe({ "yabai_window_created", "yabai_application_visable" }, trigger_space_windows_change_event)
-- space_windows_change: Update app icons in space.
space_window_observer:subscribe("space_windows_change", update_space_app)


-- -----------------------------------
-- -------- Space Indicator
-- -----------------------------------
-- swap_menus_and_spaces: Toogle indicator icon and label.
space_indicator:subscribe("swap_menus_and_spaces", toggle_indicator)
-- mouse.entered: Expand indicator.
space_indicator:subscribe("mouse.entered", expand_indicator)
-- mouse.exited: Collapse indicator.
space_indicator:subscribe("mouse.exited", collapse_indicator)
-- mouse.clicked: Toogle menus and spaces.
space_indicator:subscribe("mouse.clicked", trigger_swap_menus_and_spaces_event)
