{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  swappyCaelestia = pkgs.writeShellApplication {
    name = "swappy";
    runtimeInputs = [ pkgs.swappy ];
    text = ''
      exec env GTK_THEME=Caelestia-GTK3 swappy "$@"
    '';
  };
  caelestiaCli = inputs.caelestia-shell.inputs.caelestia-cli.packages.${system}.default.override {
    swappy = swappyCaelestia;
  };
  nextWallpaper = pkgs.writeShellApplication {
    name = "caelestia-next-wallpaper";
    runtimeInputs = [
      caelestiaCli
      pkgs.coreutils
    ];
    text = ''
      caelestia wallpaper -r "$HOME/Pictures/CaelestiaWallpapers" -N

      wallpaper="$(<"$HOME/.local/state/caelestia/wallpaper/path.txt")"
      case "''${wallpaper##*/}" in
        auraFarmWallpaper.png|AuraFarmWallpaper.png)
          caelestia scheme set --name catppuccin --flavour mocha --mode dark
          ;;
        wallhaven.png|Wallhaven.png|Wallheaven.png)
          caelestia scheme set --name dynamic --mode dark --variant fruitsalad
          ;;
        roadwp.jpg)
          caelestia scheme set --name dynamic --mode dark --variant expressive
          ;;
        roman_empire.jpg)
          caelestia scheme set --name gruvbox --flavour soft --mode dark
          ;;
        *)
          caelestia scheme set --name dynamic --mode dark --variant fruitsalad
          ;;
      esac
    '';
  };
in
{
  home.packages = [ nextWallpaper ];

  programs.swappy.package = swappyCaelestia;

  programs = {
    caelestia-extras = {
      enable = true;
      autoEnable = true;
      syncOnActivation = false;
      gtk = {
        enable = true;
        directLaunch."org.gnome.Nautilus" = {
          name = "Files";
          genericName = "File Manager";
          exec = "nautilus --new-window %U";
          icon = "org.gnome.Nautilus";
          categories = [
            "GNOME"
            "GTK"
            "Utility"
            "Core"
            "FileManager"
          ];
          mimeType = [ "inode/directory" ];
          startupNotify = true;
        };
      };
    };

    caelestia = {
      enable = true;

      systemd = {
        enable = true;
        target = "graphical-session.target";
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
            terminal = [ "kitty" ];
            audio = [ "caelestia-extras pavucontrol" ];
            explorer = [ "nautilus" ];
          };
          battery.criticalLevel = 6;
        };

        lock = {
          enabled = true;
          useWallpaper = true;
          hideNotifs = true;
        };

        paths.wallpaperDir = "~/Pictures/CaelestiaWallpapers";
        session.commands.logout = [
          "hyprctl"
          "dispatch"
          "exit"
        ];
      };

      package = inputs.caelestia-shell.packages.${system}.with-cli.override {
        swappy = swappyCaelestia;
        caelestia-cli = caelestiaCli;
        extraRuntimeDeps = with pkgs; [
          kdePackages.kirigami
          kdePackages.kirigami-addons
          kdePackages.breeze
          kdePackages.qqc2-desktop-style
        ];
      };

      cli = {
        enable = true;
        package = caelestiaCli;
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
            ${pkgs.hyprland}/bin/hyprctl reload >/dev/null 2>&1 || true
          '';
        };
      };
    };
  };

}
