{...}: {
  imports = [
    ../common/default.nix
  ];

  identity.user = "steamos";

  home = {
    stateVersion = "26.05";
    username = "steamos";
    homeDirectory = "/home/steamos";
  };

  home.sessionVariables.EDITOR = "nvim";
}
