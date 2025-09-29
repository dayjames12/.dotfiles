#!/bin/bash

# WezTerm Quick Fix Script
# Fixes common WezTerm issues

set -e

echo "í´§ WezTerm Quick Fix Script"
echo "=========================="

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"

# Create config directory if it doesn't exist
mkdir -p "$WEZTERM_CONFIG_DIR"

echo "í³ WezTerm config directory: $WEZTERM_CONFIG_DIR"

# Backup existing config
if [ -f "$WEZTERM_CONFIG_DIR/wezterm.lua" ]; then
    echo "í²¾ Backing up existing configuration..."
    cp "$WEZTERM_CONFIG_DIR/wezterm.lua" "$WEZTERM_CONFIG_DIR/wezterm.lua.backup-$(date +%Y%m%d-%H%M%S)"
fi

# Install ultra-minimal config
if [ -f "$DOTFILES_DIR/wezterm/wezterm-ultra-minimal.lua" ]; then
    echo "í´§ Installing ultra-minimal WezTerm configuration..."
    cp "$DOTFILES_DIR/wezterm/wezterm-ultra-minimal.lua" "$WEZTERM_CONFIG_DIR/wezterm.lua"
    echo "âœ… Ultra-minimal configuration installed"
elif [ -f "$DOTFILES_DIR/wezterm/wezterm-minimal.lua" ]; then
    echo "í´§ Installing minimal WezTerm configuration..."
    cp "$DOTFILES_DIR/wezterm/wezterm-minimal.lua" "$WEZTERM_CONFIG_DIR/wezterm.lua"
    echo "âœ… Minimal configuration installed"
else
    echo "âŒ Configuration files not found"
    echo "Creating basic config..."
    cat > "$WEZTERM_CONFIG_DIR/wezterm.lua" << 'CONFIG'
-- Basic WezTerm Configuration
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Basic settings
config.font = wezterm.font('Consolas')
config.font_size = 12.0
config.color_scheme = 'Tokyo Night'

-- Windows specific
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'bash' }
end

return config
CONFIG
    echo "âœ… Basic configuration created"
fi

echo ""
echo "í¾‰ WezTerm fix complete!"
echo ""
echo "Next steps:"
echo "  1. Try starting WezTerm now"
echo "  2. If it still crashes, try: rm ~/.config/wezterm/wezterm.lua"
echo "  3. For more help, see: $DOTFILES_DIR/wezterm/TROUBLESHOOTING.md"
echo ""
echo "Configuration location: $WEZTERM_CONFIG_DIR/wezterm.lua"
