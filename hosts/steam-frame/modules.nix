{
  deansModules,
  steam-frame-nix,
  nixvim,
  agenix,
  ...
}: let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  homeModules = [
    steam-frame-nix.homeManagerModules.default
    ./home.nix
    nm.identity
    hm.identity
    nixvim.homeModules.nixvim
    hm.homePackages
    hm.direnv
    hm.zsh
    hm.nixvim
    hm.wezterm
    ../../users/steamos/default.nix
  ];
}
