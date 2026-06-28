{...}: {
  imports = [
    ./terminal.nix
    ../modules/terminal/tmux.nix
    ../modules/services/nix-gc.nix
  ];
}
