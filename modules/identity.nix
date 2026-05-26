{lib, ...}: {
  options.identity.user = lib.mkOption {
    type = lib.types.str;
    description = "Primary username for this host.";
  };
}
