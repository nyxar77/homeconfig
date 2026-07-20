{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
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
    runtimeInputs = [ pkgs.lxqt.pavucontrol-qt ];
    text = ''
      qss="${config.xdg.stateHome}/caelestia/theme/pavucontrol-qt.qss"

      if [ -f "$qss" ]; then
        exec pavucontrol-qt -style Fusion -stylesheet "$qss" "$@"
      fi

      exec pavucontrol-qt -style Fusion "$@"
    '';
  };
in
{
  home.packages = [ caelestiaPavucontrol ];

  home.activation.syncCaelestiaColorScheme = lib.hm.dag.entryAfter [ "dconfSettings" ]
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
      environment = [ "GTK_THEME=Caelestia-Portal" ];
    };

    settings = {
      services.smartScheme = true;

      bar = {
        status = {
          showBattery = true;
          showLockStatus = false;
        };
        persistent = false;
        showOnHover = true;
      };

      border = {
        thickness = 5;
        rounding = 15;
      };

      general.apps = {
        terminal = [ "kitty" ];
        audio = [ "pavucontrol-qt" ];
        explorer = [ "nautilus" ];
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
        enableChromium = false;
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
          ${pkgs.hyprland}/bin/hyprctl reload >/dev/null 2>&1 || true
        '';
      };
    };
  };
}
