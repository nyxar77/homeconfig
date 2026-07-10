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
    wlogout

    wofi
    wofi-pass
    wofi-emoji
  ];
  programs.swappy = {
    enable = true;
    settings = {
      Default = {
        auto_save = false;
        early_exit = false;
        fill_shape = false;
        custom_color = "rgba(243,139,168,1)";
        line_size = 5;
        paint_mode = "brush";
        save_dir = "$HOME/Pictures/Screenshots/";
        save_filename_format = "screenshot-%Y%m%d-%H%M%S.png";
        show_panel = false;
        text_font = "sans-serif";
        text_size = 20;
        transparency = 20;
        transparent = true;
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;
    # plugins = [];
    # settings
  };
  xdg.portal.enable = lib.mkForce false;
}
