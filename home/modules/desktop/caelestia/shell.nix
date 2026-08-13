{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  syncCaelestiaColorScheme = pkgs.writeShellApplication {
    name = "sync-caelestia-color-scheme";
    runtimeInputs = [
      pkgs.dconf
      pkgs.jq
    ];
    text = ''
      state_file="${config.xdg.stateHome}/caelestia/scheme.json"
      [ -r "$state_file" ] || exit 0

      case "$(jq -r '.mode // empty' "$state_file")" in
        dark)
          preference="'prefer-dark'"
          gtk_theme="'adw-gtk3-dark'"
          ;;
        light)
          preference="'prefer-light'"
          gtk_theme="'adw-gtk3'"
          ;;
        *)
          exit 0
          ;;
      esac

      if [ "$(dconf read /org/gnome/desktop/interface/color-scheme 2>/dev/null || true)" != "$preference" ]; then
        dconf write /org/gnome/desktop/interface/color-scheme "$preference"
      fi

      if [ "$(dconf read /org/gnome/desktop/interface/gtk-theme 2>/dev/null || true)" != "$gtk_theme" ]; then
        dconf write /org/gnome/desktop/interface/gtk-theme "$gtk_theme"
      fi
    '';
  };

  caelestiaPavucontrol = pkgs.writeShellApplication {
    name = "pavucontrol-qt";
    runtimeInputs = [pkgs.lxqt.pavucontrol-qt];
    text = ''
      qss="${config.xdg.stateHome}/caelestia/theme/pavucontrol-qt.qss"

      if [ -f "$qss" ]; then
        exec pavucontrol-qt -style Fusion -stylesheet "$qss" "$@"
      fi

      exec pavucontrol-qt -style Fusion "$@"
    '';
  };

  bibataSource = pkgs.runCommand "bibata-cursor-source" {} ''
    cp -r ${pkgs.bibata-cursors.src} "$out"
  '';

  syncCaelestiaCursor = pkgs.writeShellApplication {
    name = "sync-caelestia-cursor";
    runtimeInputs = [pkgs.coreutils pkgs.cbmp pkgs.clickgen pkgs.jq];
    text = ''
      state_file="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia/scheme.json"
      [ -r "$state_file" ] || exit 0

      primary="$(jq -r '.colours.primary // empty' "$state_file")"
      mode="$(jq -r '.mode // empty' "$state_file")"
      case "$primary:$mode" in
        (????????:dark) outline="ffffff" ;;
        (????????:light) outline="111111" ;;
        (*) exit 0 ;;
      esac

      source_dir="${bibataSource}"
      source_svg="$source_dir/svg/modern"
      build_file="$source_dir/build.toml"
      [ -d "$source_svg" ] && [ -r "$build_file" ] || exit 0

      data_home="''${XDG_DATA_HOME:-$HOME/.local/share}"
      icon_dir="$data_home/icons"
      work_dir="$(mktemp -d)"
      trap 'rm -rf "$work_dir"' EXIT

      cbmp -d "$source_svg" -o "$work_dir/bitmaps/Bibata-Caelestia" \
        -bc "#$primary" -oc "#$outline" -wc "#000000"
      ctgen "$build_file" -d "$work_dir/bitmaps/Bibata-Caelestia" \
        -s 24 32 48 -p x11 -o "$work_dir/icons" \
        -n Bibata-Caelestia -c "Caelestia dynamic Bibata cursor"

      generated="$work_dir/icons/Bibata-Caelestia"
      [ -d "$generated" ] || exit 0
      mkdir -p "$icon_dir"
      old="$icon_dir/Bibata-Caelestia.old"
      rm -rf "$old"
      [ -e "$icon_dir/Bibata-Caelestia" ] && mv "$icon_dir/Bibata-Caelestia" "$old"
      mv "$generated" "$icon_dir/Bibata-Caelestia"
      rm -rf "$old"

      ${pkgs.hyprland}/bin/hyprctl setcursor Bibata-Caelestia 24 >/dev/null 2>&1 || true
    '';
  };
in {
  home.packages = [caelestiaPavucontrol];

  home.activation.syncCaelestiaColorScheme =
    lib.hm.dag.entryAfter ["dconfSettings"]
    "${syncCaelestiaColorScheme}/bin/sync-caelestia-color-scheme";

  xdg.desktopEntries.pavucontrol-qt = {
    name = "PulseAudio Volume Control";
    genericName = "Volume Control";
    comment = "Adjust the volume level and select audio devices";
    exec = "pavucontrol-qt";
    icon = "multimedia-volume-control";
    categories = [
      "AudioVideo"
      "Audio"
      "Mixer"
      "Qt"
    ];
    terminal = false;
  };

  programs.caelestia = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = ["GTK_THEME=Caelestia-Portal"];
    };

    settings = {
      services.smartScheme = true;

      osd = {
        enabled = true;
        enableBrightness = true;
        # enableMicrophone = true;
      };

      dashboard = {
        enabled = true;
        showDashboard = true;
        showMedia = true;
        showPerformance = true;
        showWeather = true;
      };

      bar = {
        scrollActions = {
          workspaces = true;
          volume = true;
          brightness = true;
        };

        popouts = {
          activeWindow = true;
          tray = true;
          statusIcons = true;
        };

        /*
           clock = {
          showDate = true;
        };
        */
        statusIcons = [
          {
            id = "network";
            enabled = true;
          }
          {
            id = "bluetooth";
            enabled = true;
          }
          {
            id = "audio";
            enabled = false;
          }
          {
            id = "microphone";
            enabled = false;
          }
          {
            id = "kbLayout";
            enabled = true;
          }
          {
            id = "battery";
            enabled = true;
          }
          {
            id = "lockStatus";
            enabled = true;
          }
        ];

        persistent = false;
        showOnHover = true;
      };
      border = {
        thickness = 5;
        rounding = 15;
      };
      launcher = {
        useFuzzy = {
          apps = true;
          actions = true;
        };
      };

      general = {
        apps = {
          terminal = ["kitty"];
          audio = ["pavucontrol-qt"];
          explorer = ["nautilus"];
        };
        battery.criticalLevel = 6;
      };

      lock = {
        enabled = true;
        useWallpaper = true;
        hideNotifs = true;
      };

      paths.wallpaperDir = "~/Pictures/Wallpapers";
      session.commands.logout = [
        "hyprctl"
        "dispatch"
        "exit"
      ];
    };

    package = inputs.caelestia-shell.packages.${pkgs.system}.with-cli.override {
      extraRuntimeDeps = with pkgs; [
        kdePackages.kirigami
        kdePackages.kirigami-addons
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
      ];
    };

    cli = {
      enable = true;
      settings.theme = {
        enable = true;
        enableHypr = true;
        enableMpv = true;
        enableCava = true;
        enableFuzzel = true;
        # The bundled GTK target writes an incomplete global stylesheet.
        # User templates below provide the dynamic colours instead.
        enableGtk = false;
        enableQt = true;
        enableBtop = true;
        enableDiscord = true;
        # Brave policies live under /etc, outside Home Manager ownership.
        enableChromium = true;
        enableSpicetify = false;
        enableTerm = false;
        enablePandora = false;
        enableNvtop = false;
        enableHtop = false;
        enableWarp = false;
        enableZed = false;
        postHook = ''
          theme_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/caelestia/theme"
          gtk_portal_css="$theme_dir/gtk-portal.css"
          gtk_global_css="$theme_dir/gtk-global.css"
          hyprtoolkit_conf="$theme_dir/hyprtoolkit.conf"
          modernz_conf="$theme_dir/modernz.conf"
          qt6ct_scheme="$theme_dir/qt6ct-caelestia.conf"
          qt6ct_qss="$theme_dir/qt6ct-portal.qss"
          config_home="''${XDG_CONFIG_HOME:-$HOME/.config}"
          data_home="''${XDG_DATA_HOME:-$HOME/.local/share}"

          if [ -f "$gtk_portal_css" ]; then
            mkdir -p "$data_home/themes/Caelestia-Portal/gtk-3.0"
            cp "$gtk_portal_css" "$data_home/themes/Caelestia-Portal/gtk-3.0/gtk.css"
            rm -f "$data_home/themes/Caelestia-Portal/gtk-4.0/gtk.css"
            rmdir "$data_home/themes/Caelestia-Portal/gtk-4.0" 2>/dev/null || true

          fi

          if [ -f "$gtk_global_css" ]; then
            for gtk_version in gtk-3.0 gtk-4.0; do
              mkdir -p "$config_home/$gtk_version"
              cp "$gtk_global_css" "$config_home/$gtk_version/gtk.css"
              rm -f "$config_home/$gtk_version/thunar.css"
            done
          fi

          if [ -f "$hyprtoolkit_conf" ]; then
            mkdir -p "$config_home/hypr"
            cp "$hyprtoolkit_conf" "$config_home/hypr/hyprtoolkit.conf"
          fi

          if [ -f "$modernz_conf" ]; then
            mkdir -p "$config_home/mpv/script-opts"
            cp "$modernz_conf" "$config_home/mpv/script-opts/modernz.conf"
          fi

          if [ -f "$qt6ct_scheme" ]; then
            mkdir -p "$config_home/portal-qt/qt6ct/colors"
            cp "$qt6ct_scheme" "$config_home/portal-qt/qt6ct/colors/caelestia.conf"

            if [ -f "$config_home/qt6ct/colors/caelestia.conf" ] && cmp -s "$qt6ct_scheme" "$config_home/qt6ct/colors/caelestia.conf"; then
              rm -f "$config_home/qt6ct/colors/caelestia.conf"
            fi
          fi

          if [ -f "$qt6ct_qss" ]; then
            mkdir -p "$config_home/portal-qt/qt6ct/qss"
            cp "$qt6ct_qss" "$config_home/portal-qt/qt6ct/qss/caelestia.qss"

            if [ -f "$config_home/qt6ct/qss/caelestia.qss" ] && cmp -s "$qt6ct_qss" "$config_home/qt6ct/qss/caelestia.qss"; then
              rm -f "$config_home/qt6ct/qss/caelestia.qss"
            fi
          fi

          ${syncCaelestiaColorScheme}/bin/sync-caelestia-color-scheme
          ${syncCaelestiaCursor}/bin/sync-caelestia-cursor
          ${pkgs.hyprland}/bin/hyprctl reload >/dev/null 2>&1 || true
        '';
      };
    };
  };

  xdg.configFile."caelestia/templates/hyprtoolkit.conf".text = ''
    # Generated by Caelestia from the active scheme.
    background = 0xFF{{ background.hex }}
    base = 0xFF{{ surfaceContainer.hex }}
    text = 0xFF{{ onSurface.hex }}
    alternate_base = 0xFF{{ surfaceContainerHigh.hex }}
    bright_text = 0xFF{{ onSurface.hex }}
    accent = 0xFF{{ primary.hex }}
    accent_secondary = 0xFF{{ secondary.hex }}
    icon_theme = Papirus-Dark
    font_family = Sans Serif
    font_family_monospace = CaskaydiaCove NF
    rounding_large = 15
    rounding_small = 8
  '';

  xdg.configFile."caelestia/templates/modernz.conf".text = ''
    # Generated by Caelestia from the active scheme.
    # Keep this file generated; do not edit the copied runtime file directly.
    # Keep the fade subtle so the OSC does not cover a large part of the video.
    osc_fade_strength=25
    fade_blur_strength=100
    fade_transparency_strength=0
    window_fade_strength=70
    window_fade_blur_strength=100
    window_fade_transparency_strength=0
    tooltip_hints=yes
    force_seek_tooltip=yes
    osc_color=#{{ primary.hex }}
    window_title_color=#{{ onSurface.hex }}
    window_controls_color=#{{ onSurface.hex }}
    windowcontrols_close_hover=#{{ error.hex }}
    windowcontrols_max_hover=#{{ tertiary.hex }}
    windowcontrols_min_hover=#{{ primary.hex }}
    title_color=#{{ onSurface.hex }}
    cache_info_color=#{{ onSurfaceVariant.hex }}
    seekbar_cache_color=#{{ outline.hex }}
    seekbarfg_color=#{{ primary.hex }}
    seekbarbg_color=#{{ surfaceContainerHighest.hex }}
    seek_handle_color=#{{ primaryContainer.hex }}
    seek_handle_border_color=#{{ primary.hex }}
    time_color=#{{ onSurfaceVariant.hex }}
    chapter_title_color=#{{ onSurface.hex }}
    side_buttons_color=#{{ onSurface.hex }}
    middle_buttons_color=#{{ onSurface.hex }}
    playpause_color=#{{ onPrimaryContainer.hex }}
    held_element_color=#{{ onSurfaceVariant.hex }}
    hover_effect_color=#{{ primary.hex }}
    thumbnail_box_color=#{{ surfaceContainerLowest.hex }}
    thumbnail_box_outline=#{{ outlineVariant.hex }}
    nibble_color=#{{ primary.hex }}
    nibble_current_color=#{{ onPrimary.hex }}
    ab_loop_color=#{{ secondary.hex }}
  '';
}
