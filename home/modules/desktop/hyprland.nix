{
  pkgs,
  lib,
  ...
}: {
  # programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  home.pointerCursor = {
    name = "catppuccin-mocha-red-cursors";
    package = pkgs.catppuccin-cursors.mochaRed;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };

  home.packages = with pkgs; [
    (lib.lowPrio cliphist)
    grim
    hyprpicker
    libnotify
    slurp
    swappy
    wlogout

    wofi
    wofi-pass
    wofi-emoji
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;
    # plugins = [];
    # settings
  };
}
