{
  pkgs,
  lib,
  ...
}: let
  projectorPanel = pkgs.writeShellApplication {
    name = "projector-panel";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.quickshell
    ];
    text = ''
      runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
      pid_file="$runtime_dir/projector-panel.pid"
      mkdir -p "$runtime_dir"

      if read -r old_pid < "$pid_file" 2>/dev/null && [ -n "$old_pid" ] && [ "$old_pid" != "$$" ]; then
        if kill -0 "$old_pid" 2>/dev/null; then
          kill "$old_pid" 2>/dev/null || true
          exit 0
        fi
      fi

      printf "%s\n" "$$" > "$pid_file"
      exec quickshell -p "$HOME/.config/quickshell/projector/Projector.qml" "$@"
    '';
  };
in {
  # programs.hyprlock.enable = true;
  # services.hypridle.enable = true;

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
    nwg-displays
    projectorPanel
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
    extraConfig = builtins.readFile ./hyprland.lua;
    # plugins = [];
    # settings
  };
  xdg.configFile."hypr/start.sh" = {
    source = ./start.sh;
    executable = true;
  };

  # nyxar: standalone Quickshell projector UI, themed from Caelestia state.
  xdg.configFile."quickshell/projector/Projector.qml".source = ./projector.qml;

  xdg.portal.enable = lib.mkForce false;
}
