{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  nix-darwin,
  user,
  hostname,
  agenix,
  ...
}: let
  system = "aarch64-darwin";
in {
  "${hostname}" = nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit inputs system user hostname agenix;
      nixneovim = inputs.nixneovim;
    };
    modules = [
      {
        nixpkgs = {
          overlays = [
            inputs.nixneovim.overlays.default
            (final: prev: {
              kitty = prev.kitty.overrideAttrs (old: {
                src = prev.fetchFromGitHub {
                  owner = "kovidgoyal";
                  repo = "kitty";
                  rev = "refs/tags/v0.38.1";
                  hash = "sha256-0M4Bvhh3j9vPedE/d+8zaiZdET4mXcrSNUgLllhaPJw=";
                };
              });
            })
          ];
        };
      }
      ./configuration.nix

      agenix.nixosModules.default
      home-manager.darwinModules.home-manager
    ];
  };
}
