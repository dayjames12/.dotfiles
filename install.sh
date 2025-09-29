#!/bin/bash

# One-liner dotfiles installer
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/install.sh | bash

set -e

echo "Ì∫Ä Installing Personal Dotfiles..."

# Clone the repository
DOTFILES_DIR="$HOME/.dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    echo "Ì≥Å Updating existing dotfiles..."
    cd "$DOTFILES_DIR"
    git pull
else
    echo "Ì≥• Cloning dotfiles repository..."
    git clone https://github.com/YOUR_USERNAME/dotfiles.git "$DOTFILES_DIR"
fi

# Run the setup script
cd "$DOTFILES_DIR"
chmod +x setup.sh
./setup.sh --all

echo "‚úÖ Installation complete!"
echo "Ì¥Ñ Please restart your terminal or run: source ~/.bashrc"
