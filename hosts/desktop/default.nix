{ pkgs, inputs, ... }:
{
  imports = [
    ./packages.nix
    inputs.nixos-wsl.nixosModules.default
    ../../modules/common/host.nix
    ../../modules/common/packages/cli.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.interop.appendWindowsPath = false;

  networking.resolvconf.enable = false;

  virtualisation.docker.enable = true;

  environment.etc."resolv.conf".text = ''
    nameserver 8.8.8.8
  '';

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

  users.users.nixos.shell = pkgs.zsh;

  system.stateVersion = "25.11";
}
