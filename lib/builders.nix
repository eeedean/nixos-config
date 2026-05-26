{
  nixpkgs,
  home-manager,
  nix-darwin,
  agenix,
  nixvim,
  deansModules,
}:
let
  nixpkgsOverlayModule = {
    nixpkgs.overlays = [
      nixvim.overlays.default
      (final: _prev: {
        agenix = agenix.packages.${final.stdenv.hostPlatform.system}.default;
      })
    ];
  };

  mkSystem = builder: system: modules:
    builder {
      inherit system;
      modules = [nixpkgsOverlayModule] ++ modules;
    };

  mkHomeManagerModule = homeImports: {
    config,
    ...
  }: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${config.identity.user}.imports = homeImports;
  };
in {
  mkNixosHost = {
    system,
    modules,
    homeImports,
  }:
    mkSystem nixpkgs.lib.nixosSystem system (
      modules
      ++ [
        deansModules.nixosModules.identity
        home-manager.nixosModules.home-manager
        (mkHomeManagerModule homeImports)
      ]
    );

  mkDarwinHost = {
    system,
    modules,
    homeImports,
  }:
    mkSystem nix-darwin.lib.darwinSystem system (
      modules
      ++ [
        deansModules.nixosModules.identity
        home-manager.darwinModules.home-manager
        (mkHomeManagerModule homeImports)
      ]
    );

  forAllSystems = function:
    nixpkgs.lib.genAttrs ["aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux"] (
      system:
        function {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
        }
    );
}
