{
  config,
  pkgs,
  lib,
  ...
}:
let
  hostname = "MBP-von-Dean";
in {
  imports = [
    ../../users/edean/interactive.nix
  ];

  home = let
    aws-refresh-mfa = pkgs.python3Packages.buildPythonApplication rec {
      pname = "aws-refresh-mfa";
      version = "0.1.0";
      pyproject = false;
      propagatedBuildInputs = [];
      dontUnpack = true;
      installPhase = "install -Dm755 ${./aws-refresh-mfa.py} $out/bin/${pname}";
    };
  in {
    file."Library/Application\ Support/xbar/plugins/bahninfo.5s.sh".source = ./xbar/bahninfo.5s.sh;
    file."Library/Application\ Support/xbar/plugins/CalendarLite.1m.sh".source = ./xbar/CalendarLite.1m.sh;

    packages = with pkgs; [
      aldente
      awscli2
      aws-refresh-mfa
      bruno
      nodejs
    ];

    sessionVariables = {
      PATH = "$PATH:$HOME/Applications:/opt/homebrew/bin";
    };

    shellAliases = {
      "brewupdate" = "brew update && brew upgrade && brew upgrade --cask && brew cleanup";
      "listening-apps" = "lsof -nP -i | grep LISTEN";
      "gen-mac-addr" = ''hexdump -n5 -e'/5 "32" 5/1 ":%02X"' /dev/random | cut -c 1-'';
    };

    activation = {
      setHostName = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ "$(/bin/hostname)" != "${hostname}.local" ]; then
          /usr/sbin/scutil --set HostName "${hostname}.local"
        fi
      '';
      # This should be removed once
      # https://github.com/nix-community/home-manager/issues/1341 is closed.
      aliasApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
        new_nix_apps="${config.home.homeDirectory}/Applications/Nix"
               rm -rf "$new_nix_apps"
               mkdir -p "$new_nix_apps"
               find -H -L "$newGenPath/home-path/Applications" -name "*.app" -type d -print | while read -r app; do
                 real_app=$(readlink -f "$app")
                 app_name=$(basename "$app")
                 target_app="$new_nix_apps/$app_name"
                 echo "Alias '$real_app' to '$target_app'"
                 ${pkgs.mkalias}/bin/mkalias "$real_app" "$target_app"
               done
      '';
    };
  };

  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          tabWidth = 2;
          language = "en";
          timeFormat = "2006-01-02 15:04:05 MST";
          nerdFontsVersion = "3";
        };
      };
    };
  };
  disabledModules = ["targets/darwin/linkapps.nix"]; # to use my aliasing instead
}
