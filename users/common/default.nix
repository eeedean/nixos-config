{...}:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    packages = [];
    sessionVariables = {};

    shellAliases = {
      "formatjson" = "python -m json.tool";
      "ls" = "eza";
      "vi" = "nvim";
      "vim" = "nvim";
    };
  };
}

