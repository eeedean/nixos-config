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
    nm.gnome
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
    ../../users/dean/desktop.nix
  ];
}
