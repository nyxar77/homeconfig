{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    cargo
    nixfmt-rfc-style
    mongosh
    nix-tree
  ];
}
