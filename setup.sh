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

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Backup existing configurations
backup_configs() {
    print_header "Backing Up Existing Configurations"

    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"

    local configs=(
        "hypr"
        "waybar"
        "rofi"
        "dunst"
        "kitty"
    )

    for config in "${configs[@]}"; do
        if [[ -d "$CONFIG_DIR/$config" ]]; then
            cp -r "$CONFIG_DIR/$config" "$backup_dir/"
            print_status "Backed up $config to $backup_dir"
        fi
    done

    print_status "Backup completed at: $backup_dir"
}

# Copy configuration files
copy_configs() {
    print_header "Copying Configuration Files"

    # Copy Hyprland configs
    if [[ -d "$SCRIPT_DIR/hypr" ]]; then
        cp -r "$SCRIPT_DIR/hypr/"* "$CONFIG_DIR/hypr/"
        print_status "Copied Hyprland configuration"
    fi

    # Copy Waybar configs
    if [[ -d "$SCRIPT_DIR/waybar" ]]; then
        cp -r "$SCRIPT_DIR/waybar/"* "$CONFIG_DIR/waybar/"
        print_status "Copied Waybar configuration"
    fi

    # Copy Rofi configs
    if [[ -d "$SCRIPT_DIR/rofi" ]]; then
        cp -r "$SCRIPT_DIR/rofi/"* "$CONFIG_DIR/rofi/"
        print_status "Copied Rofi configuration"
    fi

    # Copy Dunst configs
    if [[ -d "$SCRIPT_DIR/dunst" ]]; then
        cp -r "$SCRIPT_DIR/dunst/"* "$CONFIG_DIR/dunst/"
        print_status "Copied Dunst configuration"
    fi

    # Copy scripts
    if [[ -d "$SCRIPT_DIR/scripts" ]]; then
        mkdir -p "$HOME/Projects/wasabi/scripts"
        cp -r "$SCRIPT_DIR/scripts/"* "$HOME/Projects/wasabi/scripts/"
        print_status "Copied scripts"
    fi
}

# Fix file paths in configurations
fix_paths() {
    print_header "Fixing File Paths"

    local username=$(whoami)
    local home_dir="$HOME"

    # Fix paths in hyprpaper.conf
    if [[ -f "$CONFIG_DIR/hypr/hyprpaper.conf" ]]; then
        sed -i "s|/home/oarabilekoore|$home_dir|g" "$CONFIG_DIR/hypr/hyprpaper.conf"
        print_status "Fixed paths in hyprpaper.conf"
    fi

    # Fix paths in hyprlock.conf
    if [[ -f "$CONFIG_DIR/hypr/hyprlock.conf" ]]; then
        sed -i "s|/home/oarabilekoore|$home_dir|g" "$CONFIG_DIR/hypr/hyprlock.conf"
        print_status "Fixed paths in hyprlock.conf"
    fi

    # Fix paths in rofi theme
    if [[ -f "$CONFIG_DIR/rofi/themes/old-config.rasi" ]]; then
        sed -i "s|/home/oarabilekoore|$home_dir|g" "$CONFIG_DIR/rofi/themes/old-config.rasi"
        print_status "Fixed paths in rofi theme"
    fi
}

# Make scripts executable
make_executable() {
    print_header "Making Scripts Executable"

    local scripts=(
        "$CONFIG_DIR/rofi/batterymode.sh"
        "$CONFIG_DIR/rofi/powermenu.sh"
        "$CONFIG_DIR/rofi/wallpapers.sh"
        "$CONFIG_DIR/waybar/scripts/get-brightness.sh"
        "$HOME/Projects/wasabi/scripts/get-bible-verse.js"
    )

    for script in "${scripts[@]}"; do
        if [[ -f "$script" ]]; then
            chmod +x "$script"
            print_status "Made $script executable"
        fi
    done
}

# Setup wallpapers
setup_wallpapers() {
    print_header "Setting Up Wallpapers"

    local wallpaper_dir="$HOME/Pictures/Wallpapers"
    mkdir -p "$wallpaper_dir/wallpapers"

    # Create some default wallpapers directory structure
    print_status "Wallpaper directory created at: $wallpaper_dir"
    print_warning "Please add your wallpapers to $wallpaper_dir/wallpapers/"
    print_warning "Update the paths in ~/.config/hypr/hyprpaper.conf accordingly"
}

# Setup kitty configuration
setup_kitty() {
    print_header "Setting Up Kitty Terminal"

    local kitty_conf="$CONFIG_DIR/kitty/kitty.conf"

    # Create a basic kitty configuration that matches the rice
    cat > "$kitty_conf" << 'EOF'
# Wasabi Rice Kitty Configuration
font_family JetBrainsMono Nerd Font
font_size 11.0
bold_font auto
italic_font auto
bold_italic_font auto

# Gruvbox color scheme
background #1d2021
foreground #ebdbb2
cursor #ebdbb2

# Black
color0 #1d2021
color8 #928374

# Red
color1 #cc241d
color9 #fb4934

# Green
color2 #98971a
color10 #b8bb26

# Yellow
color3 #d79921
color11 #fabd2f

# Blue
color4 #458588
color12 #83a598

# Magenta
color5 #b16286
color13 #d3869b

# Cyan
color6 #689d6a
color14 #8ec07c

# White
color7 #a89984
color15 #ebdbb2

# Window settings
window_padding_width 8
window_margin_width 0
window_border_width 0
draw_minimal_borders yes
hide_window_decorations yes

# Tab bar
tab_bar_style powerline
tab_powerline_style slanted
tab_bar_background #1d2021
active_tab_background #d65d0e
active_tab_foreground #1d2021
inactive_tab_background #3c3836
inactive_tab_foreground #a89984

# Cursor
cursor_shape block
cursor_blink_interval 0

# Performance
repaint_delay 10
input_delay 3
sync_to_monitor yes
EOF

    print_status "Created Kitty configuration"
}

# Verify installation
verify_installation() {
    print_header "Verifying Installation"

    local required_commands=(
        "hyprland"
        "waybar"
        "rofi"
        "dunst"
        "kitty"
        "bun"
    )

    local missing_commands=()

    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_commands+=("$cmd")
        fi
    done

    if [[ ${#missing_commands[@]} -eq 0 ]]; then
        print_status "All required commands are available"
    else
        print_error "Missing commands: ${missing_commands[*]}"
        print_error "Please run the install script first"
        return 1
    fi

    # Check if config files exist
    local config_files=(
        "$CONFIG_DIR/hypr/hyprland.conf"
        "$CONFIG_DIR/waybar/config.jsonc"
        "$CONFIG_DIR/rofi/config.rasi"
        "$CONFIG_DIR/dunst/dunstrc"
    )

    for file in "${config_files[@]}"; do
        if [[ -f "$file" ]]; then
            print_status "✓ $file exists"
        else
            print_error "✗ $file missing"
        fi
    done
}

# Create desktop entry for Hyprland
create_desktop_entry() {
    print_header "Creating Desktop Entry"

    local desktop_file="/usr/share/wayland-sessions/hyprland.desktop"

    if [[ ! -f "$desktop_file" ]]; then
        sudo tee "$desktop_file" > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An independent, highly customizable, dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
        print_status "Created Hyprland desktop entry"
    else
        print_status "Hyprland desktop entry already exists"
    fi
}

# Final instructions
show_final_instructions() {
    print_header "🌶️  WASABI RICE SETUP COMPLETE  🌶️"

    echo
    print_status "Configuration has been set up successfully!"
    echo
    print_status "Next steps:"
    echo "1. Add wallpapers to ~/Pictures/Wallpapers/wallpapers/"
    echo "2. Update wallpaper paths in ~/.config/hypr/hyprpaper.conf"
    echo "3. Log out and select 'Hyprland' from your display manager"
    echo "4. Use Super+D to open Rofi application launcher"
    echo "5. Use Super+R for power menu"
    echo "6. Use Super+W to change wallpapers"
    echo "7. Use Super+B for battery mode selection"
    echo
    print_status "Key bindings:"
    echo "- Super+Enter: Open terminal (kitty)"
    echo "- Super+E: Open file manager (dolphin)"
    echo "- Super+Q: Close window"
    echo "- Super+F: Toggle fullscreen"
    echo "- Super+1-5: Switch workspaces"
    echo
    print_warning "If you encounter issues, check the backup at ~/.config-backup-*"
    echo
    print_status "Enjoy your new Wasabi rice! 🌶️"
}

# Main setup function
main() {
    print_header "🌶️  WASABI RICE SETUP  🌶️"

    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        exit 1
    fi

    # Check if we're in the right directory
    if [[ ! -f "$SCRIPT_DIR/README.md" ]]; then
        print_error "Please run this script from the wasabi rice directory"
        exit 1
    fi

    backup_configs
    copy_configs
    fix_paths
    make_executable
    setup_wallpapers
    setup_kitty
    create_desktop_entry
    verify_installation
    show_final_instructions
}

# Run main function
main "$@"
