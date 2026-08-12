{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    php85
    php85Packages.composer
  ];
}
