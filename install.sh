#!/bin/bash

# One-liner dotfiles installer
# Usage: curl -fsSL https://raw.githubusercontent.com/dayjames12/.dotfiles/main/install.sh | bash

set -e

echo "Installing Personal Dotfiles..."

DOTFILES_DIR="$HOME/.dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    echo "Updating existing dotfiles..."
    cd "$DOTFILES_DIR"
    git pull
else
    echo "Cloning dotfiles repository..."
    git clone https://github.com/dayjames12/.dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
chmod +x setup.sh
./setup.sh

echo "Installation complete!"
echo "Please restart your terminal or source your shell config."
