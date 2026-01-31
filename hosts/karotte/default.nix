{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  agenix,
  ...
}: let
  system = "x86_64-linux";
  hostname = "karotte";
  user = "dean";
in
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system user hostname agenix;
      nixvim = inputs.nixvim;
    };
    modules = [
      ({pkgs, ...}:
        {
          nixpkgs = {
            overlays = [
              inputs.nixvim.overlays.default
            ];
          };
        })
        ./configuration.nix
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
    ];
  }
