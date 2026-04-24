{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules/common/core
    ../../../modules/common/packages
  ];

  environment.systemPackages = [ pkgs.fprintd ];
  networking.hostName = "nixos";
  # Permission concerns
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "surgiie"
  ];
  users.users.surgiie = {
    isNormalUser = true;
    description = "surgiie user account";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
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
  users.users.surgiie.shell = pkgs.zsh;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
