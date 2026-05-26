{deansModules, nixvim, agenix, ...}:
let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  modules = [
    nm.fonts
    nm.systemPackages
    ./configuration.nix
    agenix.nixosModules.default
  ];

  homeModules = [
    nm.identity
    hm.identity
    nixvim.homeModules.nixvim
    hm.homePackages
    hm.direnv
    hm.git
    hm.zsh
    hm.nixvim
    hm.wezterm
    ../../users/dean/default.nix
  ];
}
