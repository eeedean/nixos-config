{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  agenix,
  nixos-wsl,
  ...
}: let
  system = "x86_64-linux";
  hostname = "wsl-nixos";
  user = "edean";
in
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system user hostname agenix;
      nixvim = inputs.nixvim;
    };
    modules = [
      {
        nixpkgs = {
          overlays = [
            inputs.nixvim.overlays.default
          ];
        };
      }

      ./configuration.nix

      nixos-wsl.nixosModules.wsl
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
    ];
  }
