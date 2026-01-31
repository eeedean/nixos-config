{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  nix-darwin,
  user,
  hostname,
  agenix,
  darwinCiModule ? null,
  ...
}: let
  system = "aarch64-darwin";
in {
  "${hostname}" = nix-darwin.lib.darwinSystem {
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
            (final: prev: {
            })
          ];
        };
      }
      ./configuration.nix

      agenix.nixosModules.default
      home-manager.darwinModules.home-manager
    ] ++ lib.optional (darwinCiModule != null) darwinCiModule;
  };
}
