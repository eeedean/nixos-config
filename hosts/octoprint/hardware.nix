{
  inputs,
  config,
  modulesPath,
  pkgs,
  lib,
  hostname,
  user,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
