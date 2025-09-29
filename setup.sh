#!/bin/bash

# Personal Dotfiles Setup Script
# One-command setup for entire development environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
PLATFORM=""

# Default options
INSTALL_NEOVIM=false
INSTALL_WEZTERM=false
INSTALL_DEPENDENCIES=false
BACKUP_EXISTING=true
VERBOSE=false

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# Function to detect platform
detect_platform() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            PLATFORM="ubuntu"
        elif command -v yum &> /dev/null; then
            PLATFORM="rhel"
        elif command -v pacman &> /dev/null; then
            PLATFORM="arch"
        else
            PLATFORM="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        PLATFORM="windows"
    else
        PLATFORM="unknown"
    fi
    
    print_status "Detected platform: $PLATFORM"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to backup existing configurations
backup_existing() {
    if [ "$BACKUP_EXISTING" = false ]; then
        return
    fi
    
    print_header "Backing Up Existing Configurations"
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup existing configurations
    local configs=(
        "$HOME/.config/nvim"
        "$HOME/.config/wezterm"
        "$HOME/.bashrc"
        "$HOME/.gitconfig"
    )
    
    for config in "${configs[@]}"; do
        if [ -e "$config" ]; then
            print_status "Backing up $config"
            cp -r "$config" "$BACKUP_DIR/"
        fi
    done
    
    print_success "Backup created at: $BACKUP_DIR"
}

# Function to setup Neovim
setup_neovim() {
    print_header "Setting Up Neovim"
    
    local nvim_config_dir="$HOME/.config/nvim"
    
    # Create nvim config directory
    mkdir -p "$nvim_config_dir"
    
    # Copy nvim configuration
    if [ -d "$DOTFILES_DIR/nvim" ]; then
        print_status "Copying Neovim configuration..."
        cp -r "$DOTFILES_DIR/nvim"/* "$nvim_config_dir/"
        print_success "Neovim configuration installed"
    else
        print_error "Neovim configuration not found in dotfiles"
        return 1
    fi
}

# Function to setup WezTerm
setup_wezterm() {
    print_header "Setting Up WezTerm"
    
    local wezterm_config_dir="$HOME/.config/wezterm"
    
    # Create wezterm config directory
    mkdir -p "$wezterm_config_dir"
    
    # Copy wezterm configuration
    if [ -f "$DOTFILES_DIR/wezterm/wezterm.lua" ]; then
        print_status "Copying WezTerm configuration..."
        cp "$DOTFILES_DIR/wezterm/wezterm.lua" "$wezterm_config_dir/wezterm.lua"
        print_success "WezTerm configuration installed"
    else
        print_error "WezTerm configuration not found in dotfiles"
        return 1
    fi
}

# Function to setup shell configuration
setup_shell() {
    print_header "Setting Up Shell Configuration"
    
    # Copy bashrc
    if [ -f "$DOTFILES_DIR/.bashrc" ]; then
        print_status "Installing .bashrc..."
        cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
        print_success ".bashrc installed"
    fi
    
    # Copy gitconfig
    if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
        print_status "Installing .gitconfig..."
        cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
        print_success ".gitconfig installed"
    fi
}

# Function to show usage
show_usage() {
    echo "Personal Dotfiles Setup Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help              Show this help message"
    echo "  --no-backup             Skip backing up existing configurations"
    echo "  --all                   Setup all configurations"
    echo ""
    echo "Examples:"
    echo "  $0                      # Basic setup (copy configs only)"
    echo "  $0 --all               # Full setup"
}

# Function to parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            --no-backup)
                BACKUP_EXISTING=false
                shift
                ;;
            --all)
                INSTALL_NEOVIM=true
                INSTALL_WEZTERM=true
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Main setup function
main() {
    print_header "Personal Dotfiles Setup"
    print_status "Starting setup from: $DOTFILES_DIR"
    
    # Detect platform
    detect_platform
    
    # Parse command line arguments
    parse_args "$@"
    
    # Backup existing configurations
    backup_existing
    
    # Setup configurations
    setup_neovim
    setup_wezterm
    setup_shell
    
    # Final success message
    print_header "Setup Complete!"
    print_success "Your development environment is ready!"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.bashrc"
    echo "  2. Start Neovim: nvim"
    echo "  3. Start WezTerm: wezterm (if installed)"
    echo ""
    echo "Configuration locations:"
    echo "  - Neovim: ~/.config/nvim/"
    echo "  - WezTerm: ~/.config/wezterm/"
    echo "  - Shell: ~/.bashrc"
    echo "  - Git: ~/.gitconfig"
    echo ""
    if [ "$BACKUP_EXISTING" = true ]; then
        echo "Backup created at: $BACKUP_DIR"
    fi
}

# Run main function with all arguments
main "$@"
