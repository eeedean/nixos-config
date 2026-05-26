{
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    taps = [
      "atlassian/homebrew-acli"
    ];
    brews = import ./formulae.nix;
    casks = import ./casks.nix;
  };
}
