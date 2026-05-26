{config, lib, pkgs, ...}:
let
  user = config.home.username;
  homeDirectory = config.home.homeDirectory;
  ownSecretsScript =
    if pkgs.stdenv.isDarwin
    then ''
      if [ -d /run/agenix ]; then
        /usr/bin/sudo chown ${user} /run/agenix/*
        mkdir -p ${homeDirectory}/.ssh
        /usr/bin/sudo cp /run/agenix/id_rsa ${homeDirectory}/.ssh/id_rsa
        /usr/bin/sudo cp /run/agenix/id_rsa_pub ${homeDirectory}/.ssh/id_rsa.pub
        /usr/bin/sudo chown ${user} ${homeDirectory}/.ssh/id_rsa.pub ${homeDirectory}/.ssh/id_rsa
      fi
    ''
    else ''
      if [ -d /run/agenix ]; then
        $DRY_RUN_CMD /run/wrappers/bin/sudo chown -R ${user} /run/agenix/
        $DRY_RUN_CMD mkdir -p ${homeDirectory}/.ssh
        $DRY_RUN_CMD /run/wrappers/bin/sudo cp /run/agenix/id_rsa ${homeDirectory}/.ssh/id_rsa
        $DRY_RUN_CMD /run/wrappers/bin/sudo cp /run/agenix/id_rsa_pub ${homeDirectory}/.ssh/id_rsa.pub
        $DRY_RUN_CMD /run/wrappers/bin/sudo chown ${user} ${homeDirectory}/.ssh/id_rsa.pub ${homeDirectory}/.ssh/id_rsa
      fi
    '';
in {
  home.shellAliases.vsc = "code";

  home.activation.ownSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ownSecretsScript;
}
