#!/bin/bash

# =====================================================================
#                          🌶️   W A S A B I   🌶️
#        Author: Oarabile Koore
#        This work is under MIT. github.com/oarabilekoore/wasabi
# =====================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Check if running on Arch Linux
check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux systems only!"
        exit 1
    fi
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        exit 1
    fi
}

# Update system
update_system() {
    print_header "Updating System"
    sudo pacman -Syu --noconfirm
}

# Install required packages
install_packages() {
    print_header "Installing Required Packages"

    # Core packages from README
    local packages=(
        "rofi"
        "dunst"
        "waybar"
        "polybar"
        "hypridle"
        "hyprpaper"
        "networkmanager"
        "network-manager-applet"
        "kitty"
        "dolphin"
        "blueberry"
        "brightnessctl"
        "nm-connection-editor"

        # Additional dependencies
        "hyprland"
        "hyprlock"
        "firefox"
        "pavucontrol"
        "pamixer"
        "jq"
        "polkit-kde-agent"
        "ttf-jetbrains-mono-nerd"
        "ttf-monaspace"
        "bibata-cursor-theme"
        "tela-circle-icon-theme-git"
        "powerprofiles-daemon"
        "pipewire"
        "pipewire-pulse"
        "pipewire-alsa"
        "wireplumber"
    )

    for package in "${packages[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            print_status "$package is already installed"
        else
            print_status "Installing $package..."
            sudo pacman -S --noconfirm "$package" || {
                print_warning "Failed to install $package from official repos, trying AUR..."
                install_from_aur "$package"
            }
        fi
    done
}

# Install AUR helper (yay) if not present
install_yay() {
    if ! command -v yay &> /dev/null; then
        print_header "Installing AUR Helper (yay)"
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
    else
        print_status "yay is already installed"
    fi
}

# Install package from AUR
install_from_aur() {
    local package="$1"
    if command -v yay &> /dev/null; then
        yay -S --noconfirm "$package" || print_warning "Failed to install $package from AUR"
    else
        print_warning "yay not available, skipping AUR package $package"
    fi
}

# Install bun (JavaScript runtime)
install_bun() {
    print_header "Installing Bun"
    if ! command -v bun &> /dev/null; then
        curl -fsSL https://bun.sh/install | bash
        export PATH="$HOME/.bun/bin:$PATH"
        echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.zshrc
    else
        print_status "bun is already installed"
    fi
}

# Enable required services
enable_services() {
    print_header "Enabling System Services"

    # Enable NetworkManager
    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager

    # Enable power-profiles-daemon
    sudo systemctl enable power-profiles-daemon
    sudo systemctl start power-profiles-daemon

    # Enable Bluetooth
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

# Create necessary directories
create_directories() {
    print_header "Creating Directories"

    local directories=(
        "$HOME/.config/hypr"
        "$HOME/.config/waybar"
        "$HOME/.config/waybar/scripts"
        "$HOME/.config/rofi"
        "$HOME/.config/rofi/themes"
        "$HOME/.config/dunst"
        "$HOME/.config/kitty"
        "$HOME/Pictures/Wallpapers"
        "$HOME/Projects/wasabi/scripts"
    )

    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        print_status "Created directory: $dir"
    done
}

# Set up fonts
setup_fonts() {
    print_header "Setting Up Fonts"

    # Update font cache
    fc-cache -fv

    # Verify fonts are available
    if fc-list | grep -q "JetBrainsMono Nerd Font"; then
        print_status "JetBrainsMono Nerd Font is available"
    else
        print_warning "JetBrainsMono Nerd Font may not be properly installed"
    fi
}

# Main installation function
main() {
    print_header "🌶️  WASABI RICE INSTALLER  🌶️"

    check_arch
    check_root

    print_status "Starting installation process..."

    update_system
    install_yay
    install_packages
    install_bun
    enable_services
    create_directories
    setup_fonts

    print_header "Installation Complete!"
    print_status "Next steps:"
    echo "1. Run ./setup.sh to copy configuration files"
    echo "2. Log out and select Hyprland as your session"
    echo "3. Customize wallpapers in ~/Pictures/Wallpapers"
    echo "4. Enjoy your new rice! 🌶️"

    print_warning "You may need to reboot for all changes to take effect"
}

# Run main function
main "$@"
