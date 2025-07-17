# Wasabi ARCH HYPERLAND RICE

A spicy, modern Hyprland rice for Arch Linux featuring a clean gruvbox inspired aesthetic with powerful functionality.

## Mentions

Rofi GruvBox Theme Provided and Sourced From:
- Author: Eduardo de Sá Coêlho Ribeiro Costa
- Github: https://github.com/edudscrc

## 📦 Components

| Component | Purpose | Configuration |
|-----------|---------|---------------|
| **Hyprland** | Window Manager | `~/.config/hypr/` |
| **Waybar** | Status Bar | `~/.config/waybar/` |
| **Rofi** | Application Launcher | `~/.config/rofi/` |
| **Dunst** | Notifications | `~/.config/dunst/` |
| **Kitty** | Terminal Emulator | `~/.config/kitty/` |
| **Hyprpaper** | Wallpaper Daemon | `~/.config/hypr/hyprpaper.conf` |
| **Hyprlock** | Screen Locker | `~/.config/hypr/hyprlock.conf` |
| **Hypridle** | Idle Daemon | `~/.config/hypr/hypridle.conf` |

## 🔧 Installation

### Prerequisites

- **Arch Linux** (required)
- **Base system** with working internet connection
- **Git** for cloning the repository

### Quick Install

```bash
# Clone the repository
git clone https://github.com/oarabilekoore/wasabi.git
cd wasabi

# Make scripts executable
chmod +x install.sh setup.sh

# Run the installer (installs all dependencies)
./install.sh

# Run the setup (copies configuration files)
./setup.sh
```

### Manual Installation

If you prefer to install manually or want to understand what's being installed:

#### 1. Install Core Dependencies

```bash
# Core Hyprland packages
sudo pacman -S hyprland hyprlock hypridle hyprpaper

# Status bar and notifications
sudo pacman -S waybar rofi dunst

# Applications
sudo pacman -S kitty dolphin firefox

# System utilities
sudo pacman -S networkmanager network-manager-applet brightnessctl
sudo pacman -S blueberry pavucontrol pamixer jq
sudo pacman -S polkit-kde-agent powerprofiles-daemon

# Audio system
sudo pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber

# Fonts and themes
sudo pacman -S ttf-jetbrains-mono-nerd ttf-monaspace
yay -S bibata-cursor-theme tela-circle-icon-theme-git
```

#### 2. Install Bun (JavaScript Runtime)

```bash
curl -fsSL https://bun.sh/install | bash
```

#### 3. Enable Services

```bash
sudo systemctl enable NetworkManager bluetooth power-profiles-daemon
```

#### 4. Copy Configuration Files

```bash
# Run the setup script
./setup.sh
```

## 🎯 Key Bindings

### Window Management
- `Super + Enter` - Open terminal (Kitty)
- `Super + Q` - Close window
- `Super + F` - Toggle fullscreen
- `Super + V` - Toggle floating
- `Super + J/K` - Focus next/previous window
- `Super + H/L` - Resize windows

### Applications
- `Super + D` - Application launcher (Rofi)
- `Super + E` - File manager (Dolphin)
- `Super + B` - Web browser (Firefox)
- `Super + R` - Power menu
- `Super + W` - Wallpaper selector
- `Super + B` - Battery mode selector

### Workspaces
- `Super + 1-5` - Switch to workspace 1-5
- `Super + Shift + 1-5` - Move window to workspace 1-5

### System
- `Super + L` - Lock screen
- `Super + Shift + Q` - Quit Hyprland
- `Print` - Screenshot
- `Super + Print` - Screenshot selection

### Media Controls
- `XF86AudioRaiseVolume` - Increase volume
- `XF86AudioLowerVolume` - Decrease volume
- `XF86AudioMute` - Toggle mute
- `XF86AudioPlay` - Play/pause media
- `XF86AudioNext/Prev` - Next/previous track

## 📁 Directory Structure

```
wasabi/
├── install.sh              # Dependency installer
├── setup.sh                # Configuration setup
├── README.md               # This file
├── hypr/                   # Hyprland configuration
│   ├── hyprland.conf      # Main Hyprland config
│   ├── hyprpaper.conf     # Wallpaper configuration
│   ├── hyprlock.conf      # Lock screen configuration
│   └── hypridle.conf      # Idle daemon configuration
├── waybar/                 # Waybar configuration
│   ├── config.jsonc       # Waybar configuration
│   ├── style.css          # Waybar styling
│   └── scripts/           # Custom scripts
├── rofi/                   # Rofi configuration
│   ├── config.rasi        # Rofi configuration
│   ├── themes/            # Custom themes
│   └── *.sh               # Rofi scripts
├── dunst/                  # Dunst configuration
│   └── dunstrc            # Notification styling
└── scripts/                # Utility scripts
    └── get-bible-verse.js  # Bible verse script
```

## 🎨 Customization

### Wallpapers

1. Add your wallpapers to `~/Pictures/Wallpapers/wallpapers/`
2. Update paths in `~/.config/hypr/hyprpaper.conf`
3. Use `Super + W` to switch wallpapers with Rofi

### Colors and Themes

The rice uses a Gruvbox-inspired color scheme. To customize:

1. **Waybar**: Edit `~/.config/waybar/style.css`
2. **Rofi**: Modify `~/.config/rofi/themes/old-config.rasi`
3. **Kitty**: Update `~/.config/kitty/kitty.conf`
4. **Dunst**: Edit `~/.config/dunst/dunstrc`

### Waybar Modules

Add or remove modules by editing `~/.config/waybar/config.jsonc`:

```jsonc
{
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["battery", "network", "pulseaudio", "tray"]
}
```

### Scripts

Custom scripts are located in:
- `~/.config/waybar/scripts/` - Waybar-specific scripts
- `~/.config/rofi/` - Rofi menu scripts
- `~/Projects/wasabi/scripts/` - General utility scripts

## 🔧 Troubleshooting

### Common Issues

**Hyprland won't start**
```bash
# Check if Hyprland is installed
which Hyprland

# Check display manager configuration
ls /usr/share/wayland-sessions/
```

**Waybar not showing**
```bash
# Test waybar configuration
waybar -c ~/.config/waybar/config.jsonc
```

**Audio not working**
```bash
# Restart pipewire
systemctl --user restart pipewire
```

**Wallpaper not loading**
```bash
# Check hyprpaper configuration
hyprpaper -c ~/.config/hypr/hyprpaper.conf
```

### Logs and Debugging

```bash
# Hyprland logs
journalctl --user -u hyprland

# Check configuration syntax
hyprctl reload
```

## 📋 Dependencies

### Core Dependencies

- **rofi** - Application launcher
- **dunst** - Notification daemon
- **waybar** - Status bar
- **polybar** - Alternative status bar
- **hypridle** - Idle daemon
- **hyprpaper** - Wallpaper daemon
- **bun** - JavaScript runtime
- **nm-applet** - Network manager applet
- **kitty** - Terminal emulator
- **dolphin** - File manager
- **blueberry** - Bluetooth manager
- **brightnessctl** - Brightness control
- **nm-connection-editor** - Network connection editor

### Additional Dependencies

- **hyprland** - Window manager
- **hyprlock** - Screen locker
- **firefox** - Web browser
- **pavucontrol** - Audio control
- **pamixer** - Audio mixer
- **jq** - JSON processor
- **polkit-kde-agent** - Authentication agent
- **ttf-jetbrains-mono-nerd** - Font
- **ttf-monaspace** - Font
- **bibata-cursor-theme** - Cursor theme
- **tela-circle-icon-theme-git** - Icon theme
- **powerprofiles-daemon** - Power management
- **pipewire** - Audio system
- **pipewire-pulse** - PulseAudio compatibility
- **pipewire-alsa** - ALSA compatibility
- **wireplumber** - Session manager

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📞 Support

If you encounter any issues or have questions:

1. Check the [troubleshooting section](#-troubleshooting)
2. Open an issue on GitHub
3. Join the discussion in the issues section

## 🙏 Acknowledgments

- **Hyprland** - For the amazing window manager
- **Gruvbox** - For the color scheme inspiration
- **Arch Linux** - For the solid foundation
- **Community** - For feedback and contributions

## 🔗 Links

- [Hyprland Documentation](https://hyprland.org/)
- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar)
- [Rofi Documentation](https://github.com/davatorium/rofi)

---

**Made with 🌶️ by [Oarabile Koore](https://github.com/oarabilekoore)**

*Spice up your desktop experience!*
