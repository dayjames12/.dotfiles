# WezTerm Troubleshooting Guide

## ✅ Current Status: WORKING

The WezTerm configuration is currently working with the minimal setup. This troubleshooting guide is kept for reference.

## Quick Reference

### Current Working Configuration
- **Config File**: `wezterm-minimal.lua` (stable, tested)
- **Shell**: Git Bash (`C:/Program Files/Git/bin/bash.exe`)
- **Font**: Consolas (Windows default)
- **Theme**: Tokyo Night
- **Status**: ✅ Working and stable

### Quick Commands
```bash
# Start WezTerm
"C:/Program Files/WezTerm/wezterm.exe" start

# Setup WezTerm config
bash setup-wezterm.sh

# Use minimal config (if issues occur)
cp wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua
```

## Common Issues and Solutions

### 1. WezTerm Crashes on Startup ✅ FIXED

**Symptoms**: WezTerm opens briefly then immediately closes/crashes

**Root Cause**: Shell configuration pointing to non-existent `/bin/bash` (WSL bash)

**Solution Applied**: Updated minimal config to use full Git Bash path:
```lua
config.default_prog = { 'C:/Program Files/Git/bin/bash.exe' }
```

#### A. Configuration File Issues ✅ FIXED
- **Problem**: Invalid Lua syntax or unsupported configuration options
- **Solution**: Using minimal configuration that's been tested and verified working

#### B. Font Issues ✅ FIXED
- **Problem**: Specified fonts not available on system
- **Solution**: Using Consolas (Windows default font) for maximum compatibility

#### C. Color Scheme Issues ✅ FIXED
- **Problem**: Invalid color scheme name
- **Solution**: Using Tokyo Night (built-in scheme)

### 2. WezTerm Won't Start at All

**Symptoms**: WezTerm doesn't launch, no error messages

**Solutions**:

#### A. Reset to Default Configuration
```bash
# Remove custom config
rm ~/.config/wezterm/wezterm.lua

# WezTerm will use default settings
```

#### B. Check WezTerm Installation
```bash
# Test WezTerm
wezterm --version

# If not found, reinstall from:
# https://wezfurlong.org/wezterm/install/windows.html
```

### 3. Performance Issues

**Symptoms**: Slow startup, laggy typing, high CPU usage

**Solutions**:

#### A. Reduce Scrollback
```lua
config.scrollback_lines = 1000  -- Reduce from default 3500
```

#### B. Disable Transparency
```lua
config.window_background_opacity = 1.0  -- Disable transparency
```

#### C. Simplify Font Rules
```lua
-- Remove complex font_rules, use simple font
config.font = wezterm.font('Consolas')
```

### 4. Key Bindings Not Working

**Symptoms**: Custom key combinations don't work

**Solutions**:

#### A. Check for Conflicts
- Some key combinations conflict with system shortcuts
- Try different modifier combinations

#### B. Use Basic Bindings
```lua
config.keys = {
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'DefaultDomain',
  },
}
```

### 5. Shell Issues

**Symptoms**: Wrong shell, shell not found, permission errors

**Solutions**:

#### A. Specify Shell Path
```lua
-- For Git Bash on Windows
config.default_prog = { 'C:/Program Files/Git/bin/bash.exe' }

-- For PowerShell
config.default_prog = { 'powershell.exe' }

-- For Command Prompt
config.default_prog = { 'cmd.exe' }
```

#### B. Check Shell Availability
```bash
# Test if bash is available
bash --version

# Test if PowerShell is available
powershell --version
```

## Debugging Steps

### 1. Check WezTerm Logs
```bash
# Run WezTerm with verbose logging
wezterm --config debug_key_events=true start
```

### 2. Test Configuration Syntax
```bash
# Check Lua syntax
lua -c ~/.config/wezterm/wezterm.lua
```

### 3. Gradual Configuration
Start with minimal config and add features one by one:

1. **Basic config** (font, colors)
2. **Add key bindings**
3. **Add window settings**
4. **Add advanced features**

### 4. Platform-Specific Issues

#### Windows
- Use Windows-compatible fonts
- Check PATH environment variable
- Run as administrator if needed

#### Linux
- Install required fonts
- Check display server (X11/Wayland)
- Verify permissions

#### macOS
- Install fonts via Font Book
- Check security permissions
- Use macOS-compatible paths

## Recovery Commands

### Reset to Minimal Config
```bash
# Copy minimal configuration
cp ~/.dotfiles/wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua

# Restart WezTerm
```

### Reset to Defaults
```bash
# Remove custom configuration
rm ~/.config/wezterm/wezterm.lua

# WezTerm will use built-in defaults
```

### Backup and Restore
```bash
# Backup current config
cp ~/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua.backup

# Restore from backup
cp ~/.config/wezterm/wezterm.lua.backup ~/.config/wezterm/wezterm.lua
```

## Getting Help

1. **WezTerm Documentation**: https://wezfurlong.org/wezterm/
2. **GitHub Issues**: https://github.com/wez/wezterm/issues
3. **Configuration Examples**: https://wezfurlong.org/wezterm/config/lua.html

## Quick Fixes

### If WezTerm Won't Start:
```bash
# 1. Use minimal config
cp ~/.dotfiles/wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua

# 2. If still broken, remove config entirely
rm ~/.config/wezterm/wezterm.lua

# 3. Reinstall WezTerm if needed
```

### If Configuration is Broken:
```bash
# Restore from backup
cp ~/.config/wezterm/wezterm.lua.backup ~/.config/wezterm/wezterm.lua

# Or use minimal config
cp ~/.dotfiles/wezterm/wezterm-minimal.lua ~/.config/wezterm/wezterm.lua
```


