{deansModules, nixvim, agenix, ...}:
let
  nm = deansModules.nixosModules;
  hm = deansModules.homeManagerModules;
in {
  modules = [
    nm.fonts
    nm.age
    nm.homebrew
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
    hm.vscode
    hm.tmux
    hm.wezterm
    hm.kitty
    hm.zed
    ./home.nix
  ];
}
