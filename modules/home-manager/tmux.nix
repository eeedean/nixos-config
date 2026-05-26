{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    historyLimit = 100000;

    tmuxp.enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-fahrenheit false
        '';
      }
      better-mouse-mode
    ];
    extraConfig = ''
      set-option -g renumber-windows on
    '';
  };
}
