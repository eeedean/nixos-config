{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file.".config/zed/settings.json".source = ../zed/settings.json;
}
