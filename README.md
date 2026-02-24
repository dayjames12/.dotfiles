# .dotfiles

Personal development environment configurations — cross-platform (macOS / Linux).

## Quick Setup

### One-Liner
```bash
curl -fsSL https://raw.githubusercontent.com/dayjames12/.dotfiles/main/install.sh | bash
```

### Manual
```bash
git clone git@github.com:dayjames12/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

## What's Included

* **Neovim** — kickstart.nvim config (LSP, completion, treesitter)
* **Zsh** — macOS shell config (`.zshrc`)
* **Bash** — Linux shell config (`.bashrc`)
* **Shared Aliases** — Git shortcuts and common aliases (`.shell_common`)
* **Git** — Global gitconfig (editor, user, push settings)
* **Alacritty** — Terminal emulator config (optional)

## Setup Options

```bash
./setup.sh              # Full setup (symlinks + neovim install)
./setup.sh --no-backup  # Skip backing up existing configs
./setup.sh --help       # Show help
```

The setup script will:
- Detect your platform (macOS or Linux)
- Back up existing configs to `~/.dotfiles-backup-<timestamp>/`
- Install Neovim if not present (brew/apt/pacman)
- Symlink all config files

## Manual Symlinks

```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc              # macOS
ln -s ~/.dotfiles/.bashrc ~/.bashrc            # Linux
ln -s ~/.dotfiles/.shell_common ~/.shell_common
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
```
