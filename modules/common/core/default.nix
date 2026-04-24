{ pkgs, ... }:
{
  imports = [
    ./system.nix
    ./programs.nix
    ./services.nix
  ];
}
