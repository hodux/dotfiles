{
  description = "NixOS configuration";

  inputs = {
    # Unstable package set
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Other stuff
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, spicetify-nix, zen-browser, ... }:
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

              home-manager.extraSpecialArgs = {
                spicetify-nix = spicetify-nix;
                zen-browser = zen-browser;
              };

              home-manager.users.rintaro = ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix

              # let home-manager (and system packages) use unstable pkgs
              # nixpkgs = nixpkgs;
            }
          ];
        };
      };
    };
}
