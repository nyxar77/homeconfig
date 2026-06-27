{...}: {
  imports = [
    ../modules/theme/fonts.nix
    ../modules/theme/stylix.nix
    ../modules/terminal/kitty.nix
    ../modules/desktop/hyprland.nix
    ../modules/desktop/caelestia.nix
    ../modules/desktop/waybar.nix
    ../modules/desktop/wofi.nix
    ../modules/desktop/services.nix
    ../modules/apps/browser/firefox/firefox.nix
    ../modules/apps/keepassxc.nix
    ../modules/apps/vesktop.nix
  ];
}
