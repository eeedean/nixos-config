{pkgs, ...}:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    packages = with pkgs; [ mprocs ];
    sessionVariables = {};

    shellAliases = {
      "formatjson" = "python -m json.tool";
      "ls" = "eza";
      "vi" = "nvim";
      "vim" = "nvim";
    };
  };
}

