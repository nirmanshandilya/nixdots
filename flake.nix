{
  description = "nixos-modular-flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

    outputs = { self, nixpkgs, home-manager, stylix, niri, zen-browser, ... }@inputs:
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
          niri.nixosModules.niri
        ];
      };

      # --- HOME: Rebuilt independently with `nh home switch .` ---
      homeConfigurations."jawknee" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
          stylix.homeModules.stylix     # <-- Needed for HM stylix targets
	  inputs.niri.homeModules.niri  # provides programs.niri in HM
        ];
      };
    };
}
