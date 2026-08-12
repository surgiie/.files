{ pkgs, ... }:
{
  imports = [
    ./cli.nix
    ./desktop.nix
    ./kdash.nix
  ];
}
