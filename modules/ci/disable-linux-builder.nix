{ config, lib, ... }:
{
  nix.linux-builder.enable = lib.mkForce false;
}
