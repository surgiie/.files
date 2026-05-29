{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../modules/common/host.nix
    ../../modules/common/core
    ../../modules/common/packages
  ];

  networking.hostName = "nixos";
  networking.resolvconf.enable = false;

  users.users.surgiie = {
    isNormalUser = true;
    description = "surgiie";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  environment.etc."resolv.conf".text = ''
    nameserver 8.8.8.8
  '';

  system.stateVersion = "25.05";
}
