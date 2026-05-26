{pkgs, ...}:
{
  imports = [
    ./interactive.nix
  ];

  home.packages = with pkgs; [discord enpass firefox jetbrains.idea telegram-desktop usbutils];

  home.sessionVariables.WAYLAND_DISPLAY = "true";
}
