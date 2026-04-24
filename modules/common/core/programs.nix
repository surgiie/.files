{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = (import inputs.nixpkgs-hyprland { system = pkgs.stdenv.hostPlatform.system; }).hyprland;
    portalPackage =
      (import inputs.nixpkgs-hyprland { system = pkgs.stdenv.hostPlatform.system; })
      .xdg-desktop-portal-hyprland;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ pkgs.xdg-desktop-portal-gtk ];

  # Font configuration
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    nerd-fonts.gohufont
  ];
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ ];
    };

    # Bullet Train theme configuration
    promptInit = ''
      # Install catppuccin fuzzel theme if not already installed
      if [ ! -d $HOME/.config/fuzzel/catppuccin ]; then
        mkdir -p $HOME/.config/fuzzel
        cd /tmp
        git clone https://github.com/catppuccin/fuzzel.git catppuccin-fuzzel
        cp -r catppuccin-fuzzel/themes $HOME/.config/fuzzel/catppuccin
        rm -rf catppuccin-fuzzel
      fi
      if [ ! -f $HOME/.local/bin/hyprtoggle ];
      then
        desired_path="$HOME/.local/bin/hyprtoggle" && \
        desired_version="main" && \
        curl -o "$desired_path" "https://raw.githubusercontent.com/surgiie/hyprtoggle/$desired_version/hyprtoggle" && chmod +x "$desired_path"
      fi

      eval "$(direnv hook zsh)"
      xdg-settings set default-web-browser browse.desktop
    '';
  };
}
