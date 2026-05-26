{
  config,
  lib,
  pkgs,
  ...
}:
let
  homeDirectory =
    if lib.strings.hasSuffix "darwin" pkgs.stdenv.hostPlatform.system
    then "/Users/${config.identity.user}"
    else "/home/${config.identity.user}";
in {
  home = {
    username = lib.mkDefault config.identity.user;
    homeDirectory = lib.mkDefault homeDirectory;
  };
}
