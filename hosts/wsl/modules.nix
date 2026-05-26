{deansModules, nixvim, nixosWsl, agenix, ...}:
let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  modules = [
    nm.age
    nm.fonts
    nm.systemPackages
    ./configuration.nix
    nixosWsl.nixosModules.wsl
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
    ./home.nix
  ];
}
