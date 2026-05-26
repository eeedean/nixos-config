{lib, ...}:
{
  imports = [
    ../common/default.nix
  ];

  identity.user = "edean";

  home = {
    stateVersion = "23.11";
    username = "edean";
    # WSL overrides this back to "/home/edean" while macOS keeps "/Users/edean".
    homeDirectory = lib.mkDefault "/Users/edean";
    sessionVariables.EDITOR = "nvim";
  };
}
