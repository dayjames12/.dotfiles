-- Ultra Minimal WezTerm Configuration
-- Maximum compatibility, minimal features

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Basic font
config.font = wezterm.font('Consolas')
config.font_size = 12.0

-- Basic color scheme
config.color_scheme = 'Tokyo Night'

-- Windows specific
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'bash' }
end

return config
