{deansModules, nixvim, agenix, ...}:
let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  modules = [
    nm.fonts
    nm.systemPackages
    nm.localeDe
    nm.firewall
    nm.nixSettings
    nm.age
    ./hardware.nix
    ./configuration.nix
    ./virtualization.nix
    nm.plasma6
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
    hm.kitty
    hm.vscode
    hm.tmux
    ./home.nix
  ];
}
