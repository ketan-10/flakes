{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  inputs.agenix.url = "github:ryantm/agenix";

  outputs =
    {
      nixpkgs,
      disko,
      nixos-facter-modules,
      agenix,
      ...
    }:
    {
      
      # nixos-anywhere --flake .#minibox --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
      nixosConfigurations.minibox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };

    };
}
