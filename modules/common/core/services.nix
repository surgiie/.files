{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;

  # Enable keyd for keyboard remapping
  services.keyd = {
    enable = true;
    keyboards.default = {
      # sudo keyd monitor to see connected device IDs
      ids = [
        "*"
      ];
      settings = {
        main = {
          # Empty main section - actual mappings in control layer
        };
        control = {
          # Map Ctrl+J to Down arrow and Ctrl+K to Up arrow
          j = "down";
          k = "up";
          h = "left";
          l = "right";
        };
      };
    };
  };

}
