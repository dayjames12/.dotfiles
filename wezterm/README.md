# WezTerm Configuration

This directory contains the WezTerm terminal configuration for a stable, reliable terminal experience.

## ✅ Current Status: WORKING

The configuration is currently working with a minimal, stable setup optimized for Windows.

## Features

- **Stable Configuration**: Minimal, reliable setup that works consistently
- **Tokyo Night Theme**: Matches your Neovim color scheme
- **Essential Key Bindings**: Copy/paste, tab management, and configuration reload
- **Windows Optimized**: Configured specifically for Windows with Git Bash
- **Consolas Font**: Uses Windows default font for maximum compatibility
- **Simple Setup**: Easy installation and configuration

## Key Bindings

### Essential Commands
- `Ctrl+Shift+C`: Copy to clipboard
- `Ctrl+Shift+V`: Paste from clipboard
- `Ctrl+Shift+T`: New tab
- `Ctrl+Shift+W`: Close current tab
- `Ctrl+Shift+R`: Reload configuration

## Installation

### Automatic Setup (Recommended)

Run the setup script:
```bash
cd ~/.dotfiles
./setup-wezterm.sh
```

### Manual Setup

1. **Copy the minimal configuration file:**
   ```bash
   # On Windows (Git Bash)
   cp ~/.dotfiles/wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua
   
   # Or manually copy the file to:
   # C:\Users\[username]\.config\wezterm\wezterm.lua
   ```

2. **Start WezTerm:**
   ```bash
   "C:/Program Files/WezTerm/wezterm.exe" start
   ```

## Customization

### Changing Color Scheme

Edit `wezterm-minimal.lua` and change the `color_scheme` line:
```lua
config.color_scheme = 'Tokyo Night'  -- Current
-- config.color_scheme = 'Dark+ (default dark)'
-- config.color_scheme = 'Campbell'
```

### Changing Font

Modify the `font` configuration:
```lua
config.font = wezterm.font('Consolas')  -- Current (Windows default)
-- config.font = wezterm.font('monospace')  -- Generic fallback
```

### Adjusting Font Size

Change the `font_size` value:
```lua
config.font_size = 12.0  -- Adjust as needed
```

## Troubleshooting

### Configuration Not Loading
- Ensure the file is in the correct location: `~/.config/wezterm/wezterm.lua`
- Check WezTerm logs: `Ctrl+Shift+R` to reload, then check for errors

### Font Issues
- Install the fonts mentioned in the configuration
- Or modify the font list to use fonts you have installed

### Key Bindings Not Working
- Some key combinations might conflict with system shortcuts
- Modify the key bindings in the `config.keys` section

## Integration with Other Tools

This configuration is designed to work seamlessly with:
- **Neovim**: Matching color scheme and font preferences
- **Git Bash**: Set as default shell
- **Development Workflow**: Optimized for coding and terminal usage

## Contributing

Feel free to modify this configuration to suit your needs. Common customizations include:
- Adding new key bindings
- Changing color schemes
- Modifying font settings
- Adding custom functions

For more advanced configuration options, see the [WezTerm documentation](https://wezfurlong.org/wezterm/config/lua.html).


