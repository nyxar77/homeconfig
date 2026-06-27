{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    cargo
    nixfmt
    mongosh
    nix-tree
    codebook
    insomnia
    jetbrains.idea-oss
    devenv
  ];
}
