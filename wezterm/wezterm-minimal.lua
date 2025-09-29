-- Minimal WezTerm Configuration
-- Stable configuration that should work reliably on Windows

local wezterm = require 'wezterm'
local act = wezterm.action

-- Configuration object
local config = wezterm.config_builder()

-- ============================================================================
-- Basic Settings
-- ============================================================================

-- Font configuration - simple and reliable
config.font = wezterm.font('Consolas')
config.font_size = 12.0

-- Color scheme - use a built-in scheme
config.color_scheme = 'Tokyo Night'

-- ============================================================================
-- Window Settings
-- ============================================================================

-- Basic window settings
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95

-- Tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- ============================================================================
-- Essential Key Bindings
-- ============================================================================

config.keys = {
  -- Copy and paste
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'Clipboard',
  },

  -- Tab management
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'DefaultDomain',
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentTab { confirm = true },
  },

  -- Reload configuration
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = act.ReloadConfiguration,
  },
}

-- ============================================================================
-- Platform Specific Settings
-- ============================================================================

-- Windows specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Set default shell to Git Bash (with full path for VM compatibility)
  config.default_prog = { 'C:/Program Files/Git/bin/bash.exe' }
end

-- ============================================================================
-- Basic Features
-- ============================================================================

-- Enable scrollback
config.scrollback_lines = 5000

-- Set cursor style (removed for compatibility)
-- config.default_cursor_style = 'SteadyBlock'

-- Force software rendering for VM compatibility
config.front_end = 'Software'

-- Additional VM compatibility settings
config.enable_wayland = false
config.enable_kitty_graphics = false

return config
