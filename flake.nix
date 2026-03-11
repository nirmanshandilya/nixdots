{
  description = "nixos-modular-flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      home-manager,
      ...

    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            # The entry point for the system
            ./modules/nixosModules/hosts/nixos/configuration.nix

            # Global modules
            inputs.stylix.nixosModules.stylix
            # inputs.home-manager.nixosModules.home-manager # Install standalone home-manager
          ];
        };
        homeConfigurations."jawknee" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home.nix ];
        };
      };
    };
}
