{
  nixosModules = {
    age = import ./age.nix;
    ciDisableLinuxBuilder = import ./ci/disable-linux-builder.nix;
    identity = import ./identity.nix;
    firewall = import ./firewall.nix;
    fonts = import ./fonts.nix;
    gdmLogo = import ./gdm-logo.nix;
    gnome = import ./gnome.nix;
    gnomeBackground = import ./gnome-background.nix;
    homebrew = import ./homebrew/default.nix;
    localeDe = import ./locale-de.nix;
    nixSettings = import ./nix-settings.nix;
    plasma6 = import ./plasma6.nix;
    plymouthLogo = import ./plymouth-logo.nix;
    systemPackages = import ./system-packages.nix;
  };

  homeManagerModules = {
    direnv = import ./home-manager/direnv.nix;
    git = import ./home-manager/git.nix;
    identity = import ./home-manager/identity.nix;
    homePackages = import ./home-packages.nix;
    kitty = import ./home-manager/kitty;
    nixvim = import ./home-manager/nixvim.nix;
    tmux = import ./home-manager/tmux.nix;
    vscode = import ./home-manager/vscode.nix;
    wezterm = import ./home-manager/wezterm/wezterm.nix;
    zed = import ./home-manager/zed.nix;
    zsh = import ./home-manager/zsh/zsh.nix;
  };
}
