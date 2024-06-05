-- =============================================
-- ========== Config
-- =============================================
local surge_config = {
  position = "right",
  alias = {
    update_freq = 1,
    color = colors.blue,
  },
  padding_left  = 0,
  padding_right = -2 * settings.group_padding,
  background = { color = colors.transparent }
}



-- =============================================
-- ========== Setup
-- =============================================
local surge = sbar.add("alias", "Surge", surge_config)
sbar.add("item", "widgets.surge.padding", { position = "right", width = 2 * settings.group_padding })



-- =============================================
-- ========== Functions
-- =============================================
local function click_surge(env)
  if env.BUTTON == 'left' then sbar.exec([[open -a "Surge"]])
  elseif env.BUTTON == 'right' then sbar.exec([[open -a "Surge Dashboard"]])
  end
end



-- =============================================
-- ========== Listeners
-- =============================================
-- mouse.clicked: Open Surge or Surge Dashboard.
surge:subscribe("mouse.clicked", click_surge)
