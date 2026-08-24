{ inputs, ... }: {
  imports = [
    ../../profiles/base.nix
    ../../profiles/development.nix
    ../../profiles/desktop.nix
    ../../profiles/media.nix
    ../../profiles/gaming.nix
    ./packages.nix
    ./session.nix
    ./custom-packages
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nyx.role = "desktop";

  home = {
    username = "nyxar";
    homeDirectory = "/home/nyxar";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
  programs.projectorctl.enable = true;
}
