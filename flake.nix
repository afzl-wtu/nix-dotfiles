{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      macbook-m4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
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
