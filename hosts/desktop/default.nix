{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./packages.nix
    inputs.nixos-wsl.nixosModules.default
    ../../modules/common/packages
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.fprintd ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.interop.appendWindowsPath = false;
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.etc = {
    "resolv.conf".text = ''
      nameserver 8.8.8.8
    '';
  };
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
  };
  # Patch link loader for non-nix binaries (i.e. pip installed packages).
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ ];
    };

    # Bullet Train theme configuration
    promptInit = ''
      eval "$(direnv hook zsh)"
    '';
  };
  users.users.nixos.shell = pkgs.zsh;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
