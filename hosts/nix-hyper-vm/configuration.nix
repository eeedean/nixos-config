{
  pkgs,
  ...
}:
let
  user = "dean";
  hostname = "NixHyperVM";
in {
  identity.user = user;

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoOK2BxZdNrWgli6jnYOdlgl6o8rjk7N9FDFo3rfU3m dean.eckert@red-oak-consulting.com"
    ];
    initialPassword = "changeme";
  };

  system.stateVersion = "24.11";
}
