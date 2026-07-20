{...}: {
  imports = [
    ../modules/theme/gtk.nix
    ../modules/theme/fonts.nix
    ../modules/terminal/kitty.nix
    ../modules/desktop
    ../modules/apps/browser/firefox/firefox.nix
    ../modules/apps/keepassxc.nix
    ../modules/apps/libreoffice.nix
    ../modules/apps/vesktop.nix
  ];
}
