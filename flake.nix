{
  description = "Hosts repository for NixOS and nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/4c1018dae018162ec878d42fec712642d214fdfa";
    home-manager = {
      url = "github:nix-community/home-manager/5b56ad02dc643808b8af6d5f3ff179e2ce9593f4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };
  };

  outputs = self @ {
    nixpkgs,
    home-manager,
    nix-darwin,
    agenix,
    nixvim,
    nixos-wsl,
    disko,
    ...
  }: let
    deansModules = import ./modules;
    flakeLib = import ./lib/builders.nix {
      inherit
        agenix
        home-manager
        deansModules
        nix-darwin
        nixpkgs
        nixvim
      ;
    };
    mkNixosHost = flakeLib.mkNixosHost;
    mkDarwinHost = flakeLib.mkDarwinHost;
    forAllSystems = flakeLib.forAllSystems;
  in rec {
    darwinConfigurations."MBP-von-Dean" = let
      host = import ./hosts/darwin/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkDarwinHost {
        system = "aarch64-darwin";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    darwinCiConfigurations."MBP-von-Dean" = let
      host = import ./hosts/darwin/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkDarwinHost {
        system = "aarch64-darwin";
        homeImports = host.homeModules;
        modules = host.modules ++ [deansModules.nixosModules.ciDisableLinuxBuilder];
      };

    nixosConfigurations.wsl = let
      host = import ./hosts/wsl/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
        nixosWsl = nixos-wsl;
      };
    in
      mkNixosHost {
        system = "x86_64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    nixosConfigurations.karotte = let
      host = import ./hosts/karotte/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "x86_64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    homeConfigurations."karotte" = let
      system = "x86_64-linux";
      host = import ./hosts/karotte/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [nixvim.overlays.default];
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = host.homeModules;
      };

    nixosConfigurations."NixUTM" = let
      host = import ./hosts/nix-utm/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "aarch64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    nixosConfigurations."NiXPS" = let
      host = import ./hosts/nixps/modules.nix {
        inherit
          agenix
          disko
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "x86_64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    nixosConfigurations."VirtualNix" = let
      host = import ./hosts/virtual-nix/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "x86_64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    nixosConfigurations."NixHyperVM" = let
      host = import ./hosts/nix-hyper-vm/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "x86_64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    nixosConfigurations."octoprint" = let
      host = import ./hosts/octoprint/modules.nix {
        inherit
          agenix
          deansModules
          nixvim
        ;
      };
    in
      mkNixosHost {
        system = "aarch64-linux";
        homeImports = host.homeModules;
        modules = host.modules;
      };

    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);
  };
}
