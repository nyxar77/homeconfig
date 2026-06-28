{...}: {
  imports = [
    ../modules/shell/zsh.nix
    ../modules/shell/starship.nix
    ../modules/terminal/packages.nix
    ../modules/terminal/bat.nix
    ../modules/terminal/ripgrep.nix
    ../modules/terminal/fastfetch.nix
    ../modules/terminal/tealdeer.nix
    ../modules/services/ssh.nix
  ];
}
