local colors   = require("colors")


sbar.bar({
  color        = colors.bar.bg,
  border_color = colors.bar.border,

  position      = "top",
  y_offset      = 3,
  height        = 32,
  border_width  = 0,
  margin        = 0,
  corner_radius = 0,

  padding_left  = 10,
  padding_right = 10,

  topmost = "window",  -- Set to `window` to avoid sketchybar being covered by windows.
  sticky  = true,

  notch_width = 350,

  font_smoothing = false,
  shadow         = false,
})
