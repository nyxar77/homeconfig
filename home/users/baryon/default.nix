{inputs, ...}: {
  imports = [
    ../../profiles/server.nix
    ./packages.nix
    ./session.nix
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home = {
    username = "baryon";
    homeDirectory = "/home/baryon";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
