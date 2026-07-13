{...}: {
  imports = [
    ../modules/theme/gtk.nix
    ../modules/theme/fonts.nix
    ../modules/theme/stylix.nix
    ../modules/terminal/kitty.nix
    ../modules/desktop
    ../modules/apps/browser/firefox/firefox.nix
    ../modules/apps/keepassxc.nix
    ../modules/apps/vesktop.nix
  ];
}
