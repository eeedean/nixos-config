{
  pkgs,
  ...
}:
let
  user = "edean";
  hostname = "wsl-nixos";
in {
  identity.user = user;

  nixpkgs = {
    config.allowUnfree = true;
  };

  time.timeZone = "Europe/Berlin";

  networking.hostName = "${hostname}";

  systemd.tmpfiles.rules = [
    "d /home/${user}/.config 0755 ${user} users"
    "d /home/${user}/.config/lvim 0755 ${user} users"
  ];

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];

  environment.enableAllTerminfo = true;

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoOK2BxZdNrWgli6jnYOdlgl6o8rjk7N9FDFo3rfU3m dean.eckert@red-oak-consulting.com"
    ];
  };

  system.stateVersion = "23.11";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = user;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  nix = {
    settings = {
      trusted-users = [user];

      accept-flake-config = true;
      auto-optimise-store = true;
    };

    extraOptions = ''experimental-features = nix-command flakes'';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
