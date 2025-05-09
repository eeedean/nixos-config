{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    universal-ctags
    eza
    hl-log-viewer
    nix-output-monitor
    nushell
    openshift
    rename
    wget
    jq
  ];
}
