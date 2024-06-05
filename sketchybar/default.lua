local settings = require("settings")
local colors   = require("colors")


sbar.default({
  updates = "when_shown",
  update_freq = 0,

  padding_left  = 0,
  padding_right = 0,
  scroll_texts = true,

  icon = {
    font = {
      family = settings.font.text,
      style  = settings.font.style_map["Bold"],
      size   = 14.0,
    },
    color         = colors.white,
    padding_left  = settings.item_padding,
    padding_right = settings.item_padding,
    -- background = { image = { corner_radius = 6 } },
  },

  label = {
    font = {
      family = settings.font.text,
      style  = settings.font.style_map["Medium"],
      size   = 12.0,
    },
    color         = colors.white,
    padding_left  = settings.item_padding,
    padding_right = settings.item_padding,
  },

  background = {
    drawing       = false,
    height        = 26,
    border_color  = colors.border_color,
    border_width  = 0,
    corner_radius = 25,
    padding_left  = 0,
    padding_right = 0,
    -- image = { corner_radius = 25, border_color = colors.black, border_width = 1, },
  },

  popup = {
    background = {
      color         = colors.popup.bg,
      border_color  = colors.popup.border,
      border_width  = 2,
      corner_radius = 10,
      -- shadow = { drawing = true },
    },
    blur_radius = 50,
  },
})
