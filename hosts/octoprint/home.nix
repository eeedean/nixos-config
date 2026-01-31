{
  config,
  lib,
  pkgs,
  inputs,
  user,
  hostname,
  age,
  ...
}: {
  imports = [
    ../../modules/home-packages.nix
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/nixvim.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home = {
    stateVersion = "23.11";

    username = "${user}";

    file.".config/zsh/p10k.zsh".source = ../../modules/home-manager/zsh/.p10k.zsh;

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

    # Session Variables
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      "formatjson" = "python -m json.tool";
      "ls" = "eza";
      "vi" = "nvim";
      "vim" = "nvim";
    };
  };

  # Programs
  programs = {
    # Home Manager
    home-manager.enable = true;
  };
}
