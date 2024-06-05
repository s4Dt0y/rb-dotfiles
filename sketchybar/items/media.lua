-- =============================================
-- ========== General
-- =============================================
local whitelist = { ["Spotify"] = true, ["Music"] = true }



-- =============================================
-- ========== Config
-- =============================================
local media_cover_config = {
  position = "e",
  updates = true,
  drawing = false,
  padding_left = 50,
  background = { color = colors.transparent, image = { string = "media.artwork", scale = 0.9 } },
  label = { drawing = false },
  icon  = { drawing = false },
  popup = { align = "center", horizontal = true },
}


local media_title_config = {
  position = "e",
  updates = false,
  drawing = false,
  width = 0,

  icon = { drawing = false },
  label = {
    string = "Title",
    font = { style = "SemiBold", size = 11.5 },
    color = colors.with_alpha(colors.green, 0.85),
    padding_left = 2 * settings.item_padding,
    y_offset = 7,
    width = 85,
    max_chars = 12,
  },
}


local media_artist_config = {
  position = "e",
  updates = false,
  drawing = false,

  icon = { drawing = false },
  label = {
    string = "Artist",
    font = { size = 9.5 },
    color = colors.with_alpha(colors.blue, 0.90),
    padding_left = 2 * settings.item_padding,
    y_offset = -7,
    width = 85,
    max_chars = 15,
  },
  -- background = { color = colors.red },
}



-- =============================================
-- ========== Setup
-- =============================================
local media_cover  = sbar.add("item", "media.cover", media_cover_config)
local media_title  = sbar.add("item", "media.title", media_title_config)
local media_artist = sbar.add("item", "media.artist", media_artist_config)


-- -----------------------------------
-- -------- Popup Menus
-- -----------------------------------
-- sbar.add("item", {
--   position = "popup." .. media_cover.name,
--   icon = { string = icons.media.back },
--   label = { drawing = false },
--   click_script = "nowplaying-cli previous",
-- })
-- sbar.add("item", {
--   position = "popup." .. media_cover.name,
--   icon = { string = icons.media.play_pause },
--   label = { drawing = false },
--   click_script = "nowplaying-cli togglePlayPause",
-- })
-- sbar.add("item", {
--   position = "popup." .. media_cover.name,
--   icon = { string = icons.media.forward },
--   label = { drawing = false },
--   click_script = "nowplaying-cli next",
-- })



-- =============================================
-- ========== Functions
-- =============================================

---Update media status.
---@param env table Evirnoment variables.
local function update_media_status(env)
  if whitelist[env.INFO.app] then
    local drawing = env.INFO.state == "playing"
    media_cover:set({ drawing = drawing })
    media_title:set({ drawing = drawing, label = env.INFO.title })
    media_artist:set({ drawing = drawing, label = env.INFO.artist })
  end
end


---Toggle media popup window.
---@param env table Evirnoment variables.
local function toggle_media_popup_window(env) media_cover:set({ popup = { drawing = "toggle" } }) end


---Collapse media popup window.
---@param env table Evirnoment variables.
local function collapse_media_popup_window(env) media_cover:set({ popup = { drawing = false } }) end



-- =============================================
-- ========== Listeners
-- =============================================
-- media_change: Update media state.
media_cover:subscribe("media_change", update_media_status)
-- -- mouse.clicked: Toggle popup.
-- media_cover:subscribe("mouse.clicked", toggle_media_popup_window)
-- -- mouse.exited.global: Close popup.
-- media_cover:subscribe("mouse.exited.global", collapse_media_popup_window)
