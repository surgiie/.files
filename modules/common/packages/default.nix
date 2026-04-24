{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    keyd
    lsof
    navi
    envsubst
    dig
    claude-code
    openssl
    tree-sitter
    fd
    zsh-forgit
    gcc
    gh
    opencode
    cjson
    postman
    zoom-us
    eza
    wl-clipboard
    jq
    git
    yq-go
    fzf
    devenv
    nixfmt
    direnv
    htop
    wl-kbptr
    wlrctl
    bat
    google-chrome
    ffmpeg
    gnumake
    neovim
    yazi
    unzip
    slack
    ripgrep
    stow
    wezterm
    wget
    zsh
    imagemagick
    ueberzugpp
    bash-language-server
    shfmt
    shellcheck
    nodejs_24
    # TypeScript/JavaScript LSP servers
    typescript-language-server
    emmet-language-server
    # Python LSP servers
    python313Packages.python-lsp-server
    python-pywayland
    python-pycairo
    python-opencv
    python-numpy
    libxkbcommon

    ruff
    # Lua LSP server
    stylua
    lua-language-server
    # Hyprland-related packages
    waybar
    hyprpaper
    hyprshot
    hyprlock
    hypridle
    xdg-desktop-portal-gtk
    swaynotificationcenter
    gnome-control-center
    pavucontrol
    networkmanagerapplet
    blueman
    fuzzel
    socat
  ];
  programs.npm.enable = true;
}
