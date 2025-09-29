# WezTerm Troubleshooting Guide

## Common Issues and Solutions

### 1. OpenGL Error: "The OpenGL implementation is too old to work with glium"

This error occurs when running WezTerm in virtual machines or systems with limited graphics support.

**Solution: Use Software Rendering**

Add this to your `~/.bashrc` or `~/.bash_profile`:
```bash
export WEZTERM_RENDERER=Software
```

Or run WezTerm with software rendering:
```bash
WEZTERM_RENDERER=Software wezterm
```

### 2. Mouse Bindings Configuration Error

If you see errors about invalid mouse button variants, the minimal configuration is automatically used which disables mouse bindings for compatibility.

### 3. VM-Specific Issues

For virtual machines, the setup script automatically installs the minimal WezTerm configuration (`wezterm-minimal.lua`) which:
- Removes advanced features that may cause issues
- Uses basic fonts and settings
- Disables mouse bindings
- Focuses on core functionality

### 4. Alternative Terminal Emulators

If WezTerm continues to have issues on your VM, consider these alternatives:

**For Linux VMs:**
- `gnome-terminal`
- `xterm`
- `alacritty` (if available)

**For Windows VMs:**
- Windows Terminal
- PowerShell
- Command Prompt

### 5. Manual Configuration

If you need to manually switch configurations:

```bash
# Use minimal config
cp ~/.dotfiles/wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua

# Use full config (may have compatibility issues on VMs)
cp ~/.dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

### 6. Checking WezTerm Version

```bash
wezterm --version
```

Make sure you have a recent version. Older versions may have compatibility issues.

### 7. Logs and Debugging

Enable verbose logging:
```bash
WEZTERM_LOG=debug wezterm
```

This will show detailed error messages to help diagnose issues.