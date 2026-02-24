#!/bin/bash

# Personal Dotfiles Setup Script
# Cross-platform: macOS (zsh) / Linux (bash)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
PLATFORM=""

# Default options
BACKUP_EXISTING=true

# Colored output helpers
print_status()  { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
print_header()  {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

command_exists() { command -v "$1" >/dev/null 2>&1; }

# Detect platform
detect_platform() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command_exists apt-get; then
            PLATFORM="ubuntu"
        elif command_exists pacman; then
            PLATFORM="arch"
        else
            PLATFORM="linux"
        fi
    else
        PLATFORM="unknown"
    fi
    print_status "Detected platform: $PLATFORM"
}

# Backup existing configs before overwriting
backup_existing() {
    if [ "$BACKUP_EXISTING" = false ]; then return; fi

    print_header "Backing Up Existing Configurations"
    mkdir -p "$BACKUP_DIR"

    local configs=(
        "$HOME/.config/nvim"
        "$HOME/.bashrc"
        "$HOME/.zshrc"
        "$HOME/.shell_common"
        "$HOME/.gitconfig"
    )

    for config in "${configs[@]}"; do
        if [ -e "$config" ] || [ -L "$config" ]; then
            print_status "Backing up $config"
            cp -rL "$config" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done

    print_success "Backup created at: $BACKUP_DIR"
}

# Create a symlink, removing any existing file/link first
make_link() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        rm -rf "$dest"
    fi
    ln -s "$src" "$dest"
    print_success "Linked $dest -> $src"
}

# Setup shell configs (symlinks)
setup_shell() {
    print_header "Setting Up Shell Configuration"

    # Shared config (both platforms)
    make_link "$DOTFILES_DIR/.shell_common" "$HOME/.shell_common"
    make_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

    if [ "$PLATFORM" = "macos" ]; then
        make_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
        print_status "Linked .zshrc for macOS"
    else
        make_link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
        print_status "Linked .bashrc for Linux"
    fi
}

# Setup Neovim: install if needed, then symlink config
setup_neovim() {
    print_header "Setting Up Neovim"

    # Install neovim if not present
    if ! command_exists nvim; then
        print_status "Installing Neovim..."
        if [ "$PLATFORM" = "macos" ]; then
            brew install neovim
        elif [ "$PLATFORM" = "ubuntu" ]; then
            sudo apt-get update && sudo apt-get install -y neovim
        elif [ "$PLATFORM" = "arch" ]; then
            sudo pacman -S --noconfirm neovim
        else
            print_warning "Please install Neovim manually for your platform"
        fi
    else
        print_status "Neovim already installed: $(nvim --version | head -1)"
    fi

    # Symlink nvim config
    mkdir -p "$HOME/.config"
    make_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
}

# Usage
show_usage() {
    echo "Personal Dotfiles Setup Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  --no-backup       Skip backing up existing configurations"
}

# Parse args
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)   show_usage; exit 0 ;;
            --no-backup) BACKUP_EXISTING=false; shift ;;
            *)           print_error "Unknown option: $1"; show_usage; exit 1 ;;
        esac
    done
}

# Main
main() {
    print_header "Personal Dotfiles Setup"
    print_status "Starting setup from: $DOTFILES_DIR"

    detect_platform
    parse_args "$@"
    backup_existing
    setup_neovim
    setup_shell

    print_header "Setup Complete!"
    print_success "Your development environment is ready!"
    echo ""
    echo "Configuration locations:"
    echo "  - Neovim:  ~/.config/nvim -> $DOTFILES_DIR/nvim"
    echo "  - Git:     ~/.gitconfig -> $DOTFILES_DIR/.gitconfig"
    if [ "$PLATFORM" = "macos" ]; then
        echo "  - Shell:   ~/.zshrc -> $DOTFILES_DIR/.zshrc"
    else
        echo "  - Shell:   ~/.bashrc -> $DOTFILES_DIR/.bashrc"
    fi
    echo "  - Shared:  ~/.shell_common -> $DOTFILES_DIR/.shell_common"
    echo ""
    echo "Next steps:"
    if [ "$PLATFORM" = "macos" ]; then
        echo "  1. Restart your terminal or run: source ~/.zshrc"
    else
        echo "  1. Restart your terminal or run: source ~/.bashrc"
    fi
    echo "  2. Start Neovim: nvim (plugins will auto-install)"
}

main "$@"
