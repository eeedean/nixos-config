{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  home.file.".ssh/allowed_signers".text = "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoOK2BxZdNrWgli6jnYOdlgl6o8rjk7N9FDFo3rfU3m dean.eckert@red-oak-consulting.com";
  programs.git = {
    enable = true;

    package = pkgs.git;

    signing.format = "openpgp";
    settings = {
      user = {
        name = "Dean Eckert";
        email = "dean.eckert@red-oak-consulting.com";
      };

      commit.gpgsign = true;

      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      signing.signByDefault = true;
      tag.sort = "version:refname";
      diff.algorithm = "histogram";
      help.autocorrect = "prompt";
      pager.branch = false;
    };

    # https://mipmip.github.io/home-manager-option-search/?programs.git.ignores
    ignores = [
      ".DS_Store"
      ".idea"
      ".direnv"
      ".devenv"
    ];
  };
}
