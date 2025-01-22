{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    universal-ctags
    eza
    nushell
    openshift
    wget
    jq
  ];
}
