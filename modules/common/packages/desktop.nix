{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Browser / communication
    google-chrome
    slack
    zoom-us
    postman
    opencode

    # Hyprland ecosystem
    waybar
    hyprpaper
    hyprshot
    hyprlock
    hypridle
    fuzzel
    swaynotificationcenter

    # Wayland utilities
    wl-kbptr
    wlrctl
    keyd
    xdg-desktop-portal-gtk

    # Audio / bluetooth / networking UI
    pavucontrol
    networkmanagerapplet
    blueman
    gnome-control-center

    # Media
    inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
