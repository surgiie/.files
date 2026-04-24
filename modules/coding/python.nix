{
  pkgs,
  lib,
  config,
  ...
}:
let
  version = "3.13";
  package = pkgs.python313;

  # https://github.com/NixOS/nixpkgs/blob/c339c066b893e5683830ba870b1ccd3bbea88ece/nixos/modules/programs/nix-ld.nix#L44
  # > We currently take all libraries from systemd and nix as the default.
  ldlibpath = lib.makeLibraryPath (
    with pkgs;
    [
      stdenv.cc.cc.lib
    ]
  );

  python_patched = (
    pkgs.python313.overrideAttrs (previousAttrs: {
      # Add the nix-ld libraries to the LD_LIBRARY_PATH.
      # creating a new library path from all desired libraries
      postInstall = previousAttrs.postInstall + ''
        mv "$out/bin/python$version" "$out/bin/unpatched_python$version"
        cat << EOF >> "$out/bin/python$version"
        #!/run/current-system/sw/bin/bash
        export LD_LIBRARY_PATH="${ldlibpath}"
        exec "$out/bin/unpatched_python$version" "\$@"
        EOF
        chmod +x "$out/bin/python$version"
      '';
    })
  );

  python_bundle = python_patched.withPackages (
    ps: with ps; [
      black
      flake8
      pip
      psycopg2
      pyserial
      setuptools
    ]
  );
in
{
  environment.systemPackages = with pkgs; [
    python_bundle
  ];

  # Make C++ libraries available for Python packages with C extensions
  # Using environment.variables instead of sessionVariables to avoid breaking authentication
  environment.variables = {
    LD_LIBRARY_PATH = "${ldlibpath}:$LD_LIBRARY_PATH";
  };
}
