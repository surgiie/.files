{ pkgs, config, ... }:
{
  packages = with pkgs; [
    lua
    lua-language-server
    stylua
  ];
}
