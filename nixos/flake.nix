{
  description = "NixOS configuration";

  inputs = {
    # Unstable package set
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    # Caelestia
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, spicetify-nix, zen-browser, caelestia-shell, caelestia-cli, ... }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Pass arguments to ./home.nix
              home-manager.extraSpecialArgs = {
                spicetify-nix = spicetify-nix;
                zen-browser = zen-browser;
                caelestia-shell = caelestia-shell;
                caelestia-cli = caelestia-cli;
              };

              home-manager.users.rintaro = ./home.nix;

            }
          ];
        };
      };
    };
}
