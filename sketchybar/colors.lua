return {
  almost_transparent = 0x0D000000,  -- BUG: For triggering click events
  transparent = 0x00000000,
  black       = 0xFF181926,
  gray        = 0xFF939AB7,
  white       = 0xFFCAD3F5,
  red         = 0xFFED8796,
  error       = 0xFFED8796,
  orange      = 0xFFF5A97F,
  yellow      = 0xFFEED49F,
  warning     = 0xFFEED49F,
  green       = 0xFFA6DA95,
  success     = 0xFFA6DA95,
  magenta     = 0xFFC6A0F6,
  stardust    = 0xFF9999FF,
  blue        = 0xFF8AADF4,
  cyan        = 0xFF74C7EC,

  bar = { bg = 0x00000000, border = 0xFFFF0000 },
  popup = { bg = 0xFF2E2E2E, border = 0xFF9999FF },
  border_color = 0xFFFF0000,  -- 0x3DE0E1E1

  status = { active = 0xFF2E2E2E, inactive = 0x88F9F9F9 },

  battery = {
    health = 0xFFA6DA95,
    normal = 0xFFF5A97F,
    death  = 0xFFED8796,
  },

  app = {
    qq      = 0xFF87AEEB,
    wechat  = 0xFF5ECD72,
    mail    = 0xFF5595DB,
    discord = 0xFF7C8BEA,
  },

  yabai = {
    error   = 0xFFED8796,
    float   = 0xFF8AADF4,
    bsp     = 0xFFEED49F,
    stack   = 0xFFC6A0F6,
    special = 0xFFF5A97F,
  },


  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00FFFFFF) | (math.floor(alpha * 255.0) << 24)
  end,
}
