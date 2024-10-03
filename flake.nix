{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.moriya= nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./globalpackages.nix
        ./machines/moriya/configuration.nix
        ./machines/moriya/hardware-configuration.nix
        ./machines/moriya/systempackages.nix
        ./machines/moriya/nvidia.nix

        home-manager.nixosModules.default
      ];
    };

    homeManagerConfigurations.home= home-manager.lib.homeManagerConfiguration {
      modules = [
        ./users/mvayk/home.nix
      ];
    };
  };
}

