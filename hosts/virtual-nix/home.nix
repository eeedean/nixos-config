{
  pkgs,
  ...
}:
{
  imports = [
    ../../users/dean/desktop.nix
  ];

  home.sessionVariables.PATH = "$PATH:${pkgs.jetbrains.idea}/idea-ultimate/bin";
}
