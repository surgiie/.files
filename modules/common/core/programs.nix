{ pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

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
    promptInit = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
