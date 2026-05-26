{...}:
{
  imports = [
    ../../users/edean/interactive.nix
  ];

  # WSL uses the Linux home directory.
  home.homeDirectory = "/home/edean";
}
