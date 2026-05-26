{
  modulesPath,
  lib,
  pkgs,
  ...
}:
let
  hostname = "octoprint";
in {
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
