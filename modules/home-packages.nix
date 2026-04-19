{pkgs, ...}: {
  home.packages = with pkgs; [
    attic-client
    coreutils
    universal-ctags
    eza
    gh
    hl-log-viewer
    lnav
    nix-output-monitor
    nushell
    omnix
    openshift
    rename
    wget
    jq
  ];
}
