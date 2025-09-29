#!/bin/bash

# WezTerm Configuration Setup Script
# This script sets up WezTerm configuration from the dotfiles repository

set -e

echo "🚀 Setting up WezTerm configuration..."

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEZTERM_CONFIG_DIR="$HOME/.config/wezterm"

# Create WezTerm config directory if it doesn't exist
echo "📁 Creating WezTerm config directory..."
mkdir -p "$WEZTERM_CONFIG_DIR"

# Copy the configuration file
echo "📋 Copying WezTerm configuration..."
if [ -f "$DOTFILES_DIR/wezterm/wezterm.lua" ]; then
    cp "$DOTFILES_DIR/wezterm/wezterm.lua" "$WEZTERM_CONFIG_DIR/wezterm.lua"
    echo "✅ WezTerm configuration copied successfully!"
else
    echo "❌ Error: wezterm.lua not found in $DOTFILES_DIR/wezterm/"
    exit 1
fi

# Check if WezTerm is installed
echo "🔍 Checking WezTerm installation..."
if command -v wezterm &> /dev/null; then
    echo "✅ WezTerm is installed"
    echo "📊 WezTerm version: $(wezterm --version)"
else
    echo "⚠️  WezTerm not found in PATH"
    echo "   Please ensure WezTerm is installed and added to your PATH"
    echo "   Download from: https://wezfurlong.org/wezterm/"
fi

# Create backup of existing config if it exists
if [ -f "$WEZTERM_CONFIG_DIR/wezterm.lua" ] && [ ! -f "$WEZTERM_CONFIG_DIR/wezterm.lua.backup" ]; then
    echo "💾 Creating backup of existing configuration..."
    cp "$WEZTERM_CONFIG_DIR/wezterm.lua" "$WEZTERM_CONFIG_DIR/wezterm.lua.backup"
fi

echo ""
echo "🎉 WezTerm configuration setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Restart WezTerm to load the new configuration"
echo "   2. Or press Ctrl+Shift+R in WezTerm to reload the config"
echo ""
echo "🔧 Configuration location: $WEZTERM_CONFIG_DIR/wezterm.lua"
echo "📖 For customization options, see: $DOTFILES_DIR/wezterm/README.md"
echo ""
echo "⌨️  Key bindings reminder:"
echo "   - Ctrl+Shift+T: New tab"
echo "   - Ctrl+Shift+D: Split horizontally"
echo "   - Ctrl+Shift+Alt+D: Split vertically"
echo "   - Ctrl+Shift+H/J/K/L: Navigate panes"
echo "   - Ctrl+Shift+R: Reload configuration"