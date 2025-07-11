{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    impermanence.url = "github:nix-community/impermanence";

    # ✅ Use home-manager as a flake input, not fetchTarball
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }@inputs: {
    nixosConfigurations = {
      macbook-m4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	        impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          ./hp/impermanence.nix
          ./hp/home-manager.nix
          ./hp/configuration.nix
        ];
      };
      custom_iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./iso/minimal_iso.nix
        ];
      };
    };
  };
}
