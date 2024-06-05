-- =============================================
-- ========== General
-- =============================================
local max_items = 15
local menu_items = {}



-- =============================================
-- ========== Config
-- =============================================
local menu_configs = {}
for i = 1, max_items, 1 do
  menu_configs[i] = {
    drawing       = false,
    padding_left  = settings.item_padding,
    padding_right = settings.item_padding,
    icon          = { drawing = false },
    label         = {
      font          = { style = settings.font.style_map[i == 1 and "Heavy" or "Semibold"], size = 13.0 },
      color         = colors.active,
      padding_left  = settings.group_padding,
      padding_right = settings.group_padding,
    },
    click_script  = ("$CONFIG_DIR/helpers/menus/bin/menus -s %s"):format(i),
  }
end



-- =============================================
-- ========== Setup
-- =============================================
-- -----------------------------------
-- -------- Menu Items
-- -----------------------------------
for i = 1, max_items, 1 do
  local menu = sbar.add("item", "menu." .. i, menu_configs[i])
  menu_items[i] = menu
end
sbar.add("bracket", { "/menu\\..*/" }, { background = { color = colors.almost_transparent } })


-- -----------------------------------
-- -------- Menu Padding
-- -----------------------------------
local menu_padding = sbar.add("item", "menu.padding", { drawing = false, width = 2 * settings.group_padding })


-- -----------------------------------
-- -------- Menu Watcher and Swaper
-- -----------------------------------
local menu_watcher    = sbar.add("item", { drawing = false, updates = false })
local space_menu_swaper = sbar.add("item", { drawing = false, updates = true })



-- =============================================
-- ========== Functions
-- =============================================

---Update menus.
---@param env table Environment variables.
local function update_menus(env)
  sbar.exec("$CONFIG_DIR/helpers/menus/bin/menus -l", function(menus)
    sbar.set("/menu\\..*/", { drawing = false })
    menu_padding:set({ drawing = true })

    local counter = 1
    for menu in string.gmatch(menus, "[^\r\n]+") do
      if counter < max_items then menu_items[counter]:set({ label = menu, drawing = true })
      else break end
      counter = counter + 1
    end
  end)
end


---Swap menus and spaces.
---@param env table Environment variables.
local function toggle_menus_and_spaces(env)
  local drawing = menu_items[1]:query().geometry.drawing == "on"
  if drawing then
    menu_watcher:set({ updates = false })
    sbar.set("/menu\\..*/",  { drawing = false })
    sbar.set("/space\\..*/", { drawing = true })
    -- sbar.set("front_app",    { drawing = true })
  else
    menu_watcher:set({ updates = true })
    sbar.set("/space\\..*/", { drawing = false })
    -- sbar.set("front_app",    { drawing = true })
    update_menus(env)
  end
end


-- =============================================
-- ========== Listeners
-- =============================================
-- front_app_switched: Update menus.
menu_watcher:subscribe("front_app_switched", update_menus)
-- swap_menus_and_spaces: Swap menus and spaces.
space_menu_swaper:subscribe("swap_menus_and_spaces", toggle_menus_and_spaces)


-- return menu_watcher
