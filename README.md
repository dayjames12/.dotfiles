# .dotfiles

Personal development environment configurations including Neovim, WezTerm, and shell settings.

## 🚀 One-Command Setup

### Super Easy Installation (Recommended)
```bash
# One-liner installation - clones repo and sets up everything
curl -fsSL https://raw.githubusercontent.com/dayjames12/.dotfiles/main/install.sh | bash
```

### Manual Setup
```bash
# Clone the repository
git clone git@github.com:dayjames12/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the setup script
./setup.sh --all
```

## What's Included

* **Neovim**: Modern configuration based on kickstart.nvim
* **WezTerm**: Terminal configuration with Tokyo Night theme
* **Git**: Git configuration
* **Bash**: Shell configuration
* **Alacritty**: Terminal configuration (optional)

## Setup Options

```bash
# Basic setup (configs only)
./setup.sh

# Full setup with dependencies
./setup.sh --all

# Setup without backing up existing configs
./setup.sh --no-backup

# Get help
./setup.sh --help
```

## Manual Symlink Setup (Alternative)

If you prefer symlinks instead of copying files:

```bash
# Linux/macOS
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -s ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
```

```powershell
# Windows PowerShell
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.bashrc" -Target "$env:USERPROFILE\.dotfiles\.bashrc"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$env:USERPROFILE\.dotfiles\.gitconfig"
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$env:USERPROFILE\.dotfiles\nvim"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\alacritty\alacritty.toml" -Target "$env:USERPROFILE\.dotfiles\alacritty.toml" -Force
```

## Backup Existing Configs

If files already exist, backup first:
```powershell
# Windows PowerShell
Rename-Item "$env:USERPROFILE\.bashrc" "$env:USERPROFILE\.bashrc.backup"
Rename-Item "$env:USERPROFILE\.gitconfig" "$env:USERPROFILE\.gitconfig.backup"
```


