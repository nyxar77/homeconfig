{
  inputs,
  ...
}: {
  imports = [
    ../../profiles/base.nix
    ../../profiles/development.nix
    ../../profiles/desktop.nix
    ../../profiles/media.nix
    ../../profiles/gaming.nix
    ./packages.nix
    ./session.nix
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  nixpkgs.config = {
    allowUnfree = true;
  };

  home = {
    username = "nyxar";
    homeDirectory = "/home/nyxar";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
