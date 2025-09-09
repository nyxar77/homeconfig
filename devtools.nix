{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    go
    rustc
    cargo
    nodejs_24
    deno
    bun
    python311
    php83Packages.composer
    luarocks
    lua5_1
    tree-sitter
    nixfmt-rfc-style
    nixd
    alejandra
    mongosh
    nix-tree
  ];
}
