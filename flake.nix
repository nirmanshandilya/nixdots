{
  description = "nixos-modular-flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:nirmanshandilya/wallpapers";
      flake = false;
    };

  };

    outputs = { self, nixpkgs, home-manager, stylix,  zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
	inherit system;
	config.allowUnfree = true;
  };
    in {
      # --- SYSTEM: Only rebuilt when system-level things change with `nh os switch .` ---
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/nixosModules/hosts/nixos/configuration.nix
          stylix.nixosModules.stylix
        ];
      };

      # --- HOME: Rebuilt independently with `nh home switch .` ---
      homeConfigurations."jawknee" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
          stylix.homeModules.stylix     # <-- Needed for HM stylix targets
        ];
      };
    };
}
