{...}:
{
  imports = [
    ../common/default.nix
  ];

  identity.user = "dean";

  home = {
    stateVersion = "23.11";
    username = "dean";
    homeDirectory = "/home/dean";
  };

  home.sessionVariables.EDITOR = "nvim";
}

