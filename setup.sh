#!/bin/bash

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES_FILE="$HOME/paclist.txt"
AUR_PACKAGES_FILE="$HOME/aurlist.txt"

# Check if packages files exist
if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Error: $PACKAGES_FILE not found"
    exit 1
fi

if [ ! -f "$AUR_PACKAGES_FILE" ]; then
    echo "Error: $AUR_PACKAGES_FILE not found"
    exit 1
fi

# Install official packages first
echo "Installing official packages..."
xargs -a "$PACKAGES_FILE" sudo pacman -S --needed --noconfirm

# Check if yay is installed, if not install it
if ! command -v yay &> /dev/null; then
    echo "Installing yay AUR helper..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$SCRIPT_DIR"
    rm -rf yay
fi

# Install AUR packages
echo "Installing AUR packages..."
xargs -a "$AUR_PACKAGES_FILE" yay -S --needed --noconfirm

echo "All packages have been installed!"
