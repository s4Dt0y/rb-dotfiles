-- =============================================
-- ========== Config
-- =============================================
local front_app_config = {
  position = "left",
  display = "active",
  icon = { background = { drawing = true } },
  label = {
    font = { style = "Heavy", size = 12.5 },
    color = colors.with_alpha(colors.green, 0.9),
    -- color = colors.green,
  },
}



-- =============================================
-- ========== Setup
-- =============================================
local front_app = sbar.add("item", "front_app", front_app_config)



-- =============================================
-- ========== Functions
-- =============================================

---Update the front app icon and label.
---@param env table Environment variables.
local function update_front_app(env)
  front_app:set({
    icon = { background = { image = ("app.%s"):format(env.INFO) } },
    label = { string = env.INFO },
  })

  sbar.animate("tanh", 10, function()
    front_app:set({ icon = { background = { image = { scale = 1.0 } } } })
    front_app:set({ icon = { background = { image = { scale = 0.8 } } } })
  end)
end


---Trigger `swap_menus_and_spaces` event.
---@param env table Environment variables.
local function trigger_swap_menus_and_spaces_event(env) sbar.trigger("swap_menus_and_spaces") end



-- =============================================
-- ========== Listeners
-- =============================================
-- front_app_switched: Update the front app icon and label.
front_app:subscribe({ "front_app_switched" }, update_front_app)
-- mouse.clicked: Display the app menu.
front_app:subscribe("mouse.clicked", trigger_swap_menus_and_spaces_event)
