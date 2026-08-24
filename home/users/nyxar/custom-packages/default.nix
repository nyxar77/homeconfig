{ pkgs, ... }: {
  imports = [
    ./readest.nix
  ];

  home.packages = [
    (pkgs.callPackage ./pomotroid.nix { })
  ];

  programs.readest = {
    enable = true;
  };
}
