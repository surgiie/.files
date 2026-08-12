{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm = {
      url = "github:wezterm/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations =
        nixpkgs.lib.optionalAttrs (builtins.pathExists ./hosts/work) {
          work = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/work ];
            specialArgs = { inherit inputs; };
          };
        }
        // {
          laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/laptop ];
            specialArgs = { inherit inputs; };
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/desktop ];
            specialArgs = { inherit inputs; };
          };
        };
    };
}
