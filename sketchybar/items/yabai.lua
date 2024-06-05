-- =============================================
-- ========== General
-- =============================================
local yabai_types = {
  floating = "Float",  -- Floating window
  float    = "FLOAT",  -- Float Type
  stack    = "STACK",
  bsp      = "BSP",
}



-- =============================================
-- ========== Config
-- =============================================
local yabai_config = {
  position = "left",
  display = "active",
  padding_left = 10,
  icon = {
    string = icons.yabai.error,
    font = { style = "Bold", size = 14.0 },
    color = colors.red,
  },
  label = {
    string = "ERROR",
    font = { style = "SemiBold", size = 10.0 },
    color = colors.red,
    y_offset = 5,
  },
}



-- =============================================
-- ========== Setup
-- =============================================
local yabai = sbar.add("item", "yabai", yabai_config)


-- yabai:subscribe({ "forced" }, function(env) yabai:set({ label = "Loading..." }) end)



-- =============================================
-- ========== Functions
-- =============================================
local function set_yabai_status(icon, label, color, window_info)
  if window_info["has-parent-zoom"] then label = ("%s(ZP)"):format(label); color = colors.yabai.special end
  -- [[ "$(echo $window_info | jq -r '."has-parent-zoom"')" == 'true' ]] && label+='(ZP)' && color="$SPECIAL_STATUS"
  yabai:set({ icon = { string = icon, color = color }, label = { string = label, color = color } })
end

local function update_yabai_status(env)
  sbar.exec("yabai -m query --windows --window", function(window_info)
    local icon, label, color = icons.yabai.error, "ERROR", colors.yabai.error

    -- CASE 1: Floating Window
    if window_info["is-floating"] then
      icon, label, color = icons.yabai.float, yabai_types.floating, colors.yabai.float
      set_yabai_status(icon, label, color, window_info)
    else
      sbar.exec("yabai -m query --spaces --space", function(space_info)
        local space_type = space_info["type"]
        -- CASE 2: Float Layout
        if space_type == "float" then
          icon, label, color = icons.yabai.float, yabai_types.float, colors.yabai.float
          set_yabai_status(icon, label, color, window_info)
        else
          local stack_index = window_info["stack-index"]
          -- CASE 3: No stack index => Show layout type (BSP or Stack)
          if stack_index == 0 then
            icon, label, color = icons.yabai[space_type], yabai_types[space_type], colors.yabai[space_type]
            icon, label, color = icon or icons.yabai.error, label or "ERROR", color or colors.yabai.error
            set_yabai_status(icon, label, color, window_info)
          else  -- CASE 4: Multiple window stacking
            sbar.exec("yabai -m query --windows --window stack.last", function(stack_info)
              local last_stack_index = stack_info["stack-index"]
              icon, label, color = icons.yabai.stack, ("[%d/%d]"):format(stack_index, last_stack_index), colors.yabai.stack
              set_yabai_status(icon, label, color, window_info)
            end)
          end
        end
      end)
    end
  end)
end



-- =============================================
-- ========== Listeners
-- =============================================
yabai:subscribe({ "forced", "space_change", "skhd_space_type_changed", "skhd_window_type_changed", "yabai_loaded", "yabai_window_focused" }, update_yabai_status)
