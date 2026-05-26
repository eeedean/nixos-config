{deansModules, nixvim, agenix, ...}:
let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  modules = [
    nm.fonts
    nm.systemPackages
    nm.localeDe
    nm.nixSettings
    nm.age
    ./hardware.nix
    ./configuration.nix
    ./shared-vm.nix
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
    hm.vscode
    hm.wezterm
    hm.kitty
    hm.tmux
    ../../users/dean/interactive.nix
  ];
}
