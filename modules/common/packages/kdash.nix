{ pkgs, ... }:
let
  kdash = pkgs.stdenv.mkDerivation rec {
    pname = "kdash";
    version = "1.1.2";

    src = pkgs.fetchurl {
      url = "https://github.com/kdash-rs/kdash/releases/download/v${version}/kdash-linux-musl.tar.gz";
      hash = "sha256-fDEwpH9o8dMLqFhjXl7eM7s2CXLQITvZARYVbgyeIII=";
    };

    sourceRoot = ".";

    installPhase = ''
      install -Dm755 kdash $out/bin/kdash
    '';
  };
in
{
  environment.systemPackages = [ kdash ];
}
