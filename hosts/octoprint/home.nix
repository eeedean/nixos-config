{
  pkgs,
  ...
}:
{
  imports = [
    ../../users/dean/default.nix
  ];

  home = {
    packages = with pkgs; [
      coreutils
      universal-ctags
      eza
      hl-log-viewer
      nix-output-monitor
      rename
      wget
      jq
      usbutils
    ];
  };
}
