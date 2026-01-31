{
  config,
  pkgs,
  inputs,
  system,
  user,
  hostname,
  ...
}: {
  imports = [
    ../../modules/fonts.nix
    ../../modules/locale-de.nix
    ../../modules/firewall.nix
    ../../modules/nix-settings.nix
  ];

  environment.systemPackages = with pkgs; [
    asciidoctor
    bash-completion
    bat
    bun
    curl
    diff-so-fancy
    docker-client
    doggo
    git
    gnupg
    hexedit
    hexyl
    htop
    imagemagick
    inetutils
    jq
    lame
    nix-direnv
    nmap
    nil
    pkg-config
    ripgrep
    ripmime
    screen
    speedtest-cli
    ssh-copy-id
    tldr
    tree
    watch
    wget
    xmlstarlet
    zfind
    zsh-powerlevel10k
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoOK2BxZdNrWgli6jnYOdlgl6o8rjk7N9FDFo3rfU3m dean.eckert@red-oak-consulting.com"
    ];
    initialPassword = "changeme";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit user hostname system;
    inherit (inputs) nixneovim;
  };
  home-manager.users.${user} = {
    imports = [
      ./home.nix
    ];
  };

  services = {
    octoprint = {
      enable = true;
      port = 80;
      plugins = p: [
        p.telegram
      ];
    };

    # mjpg-streamer = {
    #   enable = true;
    #   # https://github.com/jacksonliam/mjpg-streamer/blob/master/mjpg-streamer-experimental/plugins/input_uvc/README.md
    #   inputPlugin = "input_uvc.so --fps 1 -timeout 120";
    #   outputPlugin = "output_http.so --www @www@ --nocommands --port 5050";
    # };
  };

  systemd.services.octoprint = {
    serviceConfig = {
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
    };
  };

  networking.firewall = rec {
    allowedTCPPorts = [
      80
      5050
    ];
    allowedUDPPorts = allowedTCPPorts;
  };
}
