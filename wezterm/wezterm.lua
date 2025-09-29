-- WezTerm Configuration
-- This configuration provides a modern, feature-rich terminal experience

local wezterm = require 'wezterm'
local act = wezterm.action

-- Configuration object
local config = wezterm.config_builder()

-- ============================================================================
-- General Settings
-- ============================================================================

-- Set default program to bash (since you're using Git Bash)
config.default_prog = { 'bash' }

-- Font configuration
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'Fira Code',
  'Cascadia Code',
  'Consolas',
  'monospace',
})

config.font_size = 12.0
config.line_height = 1.1

-- Enable ligatures for better code display
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      'JetBrains Mono',
      'Fira Code',
      'Cascadia Code',
      'Consolas',
      'monospace',
    }, { weight = 'Bold' }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font_with_fallback({
      'JetBrains Mono',
      'Fira Code',
      'Cascadia Code',
      'Consolas',
      'monospace',
    }, { weight = 'Bold', style = 'Italic' }),
  },
}

-- ============================================================================
-- Color Scheme
-- ============================================================================

-- Use Tokyo Night color scheme (matching your Neovim theme)
config.color_scheme = 'Tokyo Night'

-- Alternative color schemes you can try:
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'Gruvbox Dark'

-- ============================================================================
-- Window and Tab Settings
-- ============================================================================

-- Window settings
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95
config.text_background_opacity = 0.95

-- Tab bar configuration
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- Tab bar styling
config.colors = {
  tab_bar = {
    background = '#1a1b26',
    active_tab = {
      bg_color = '#7aa2f7',
      fg_color = '#1a1b26',
    },
    inactive_tab = {
      bg_color = '#24283b',
      fg_color = '#a9b1d6',
    },
    inactive_tab_hover = {
      bg_color = '#2d3142',
      fg_color = '#a9b1d6',
    },
  },
}

-- ============================================================================
-- Key Bindings
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
  {
    key = 'Tab',
    mods = 'CTRL',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1),
  },

  -- Window management
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = act.SpawnWindow,
  },
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = act.ToggleFullScreen,
  },

  -- Split panes
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },

  -- Pane resizing
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Down', 5 },
  },

  -- Close pane
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentPane { confirm = true },
  },

  -- Reload configuration
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = act.ReloadConfiguration,
  },

  -- Search
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = act.Search { Regex = '' },
  },
}

-- ============================================================================
-- Mouse Bindings
-- ============================================================================

config.mouse_bindings = {
  -- Right click to paste
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
  -- Scroll wheel to change font size
  {
    event = { Up = { streak = 1, button = 'WheelUp' } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    event = { Up = { streak = 1, button = 'WheelDown' } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

-- ============================================================================
-- Launch Configuration
-- ============================================================================

-- Set working directory to home
config.default_cwd = '~'

-- ============================================================================
-- Advanced Features
-- ============================================================================

-- Enable scrollback
config.scrollback_lines = 10000

-- Enable hyperlink support
config.hyperlink_rules = {
  {
    regex = '\\b\\w+://[^\\s]+\\b',
    format = '$0',
  },
  {
    regex = '\\b(?:file)://([^\\s]+)\\b',
    format = 'file://$1',
  },
  {
    regex = '\\b(?:git)://([^\\s]+)\\b',
    format = 'git://$1',
  },
}

-- Enable cursor blinking
config.cursor_blink_rate = 800

-- Set cursor style
config.default_cursor_style = 'BlinkingBlock'

-- ============================================================================
-- Platform Specific Settings
-- ============================================================================

-- Windows specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use Windows native font rendering
  config.freetype_load_target = 'Light'
  config.freetype_render_target = 'Light'
  
  -- Set default shell to PowerShell or Git Bash
  config.default_prog = { 'bash' }
end

-- ============================================================================
-- Custom Functions
-- ============================================================================

-- Function to get current working directory for tab titles
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  if title:match('^%w+://') then
    title = title:match('([^/]+)$')
  end
  
  return {
    { Text = ' ' .. title .. ' ' },
  }
end)

-- Function to set window title
wezterm.on('window-config-reloaded', function(window, pane)
  window:set_title('WezTerm - ' .. pane:get_title())
end)

return config