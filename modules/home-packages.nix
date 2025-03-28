{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    universal-ctags
    eza
    nix-output-monitor
    nushell
    openshift
    wget
    jq
  ];
}
