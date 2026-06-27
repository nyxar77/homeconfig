{
  inputs,
  pkgs,
  ...
}: {
  programs.caelestia = {
    enable = true;

    systemd = {
      enable = false;
      target = "graphical-session.target";
      environment = [];
    };

    cli = {
      enable = true; # ajoute la commande `caelestia`
      settings = {
        theme = {
          enable = true;
          enableThunar = true;
          enableMpv = false;
          enableHypr = true;
          enableTerm = false;
          enableDiscord = false;
          enableSpicetify = false;
          enablePandora = false;
          enableFuzzel = true;
          enableBtop = false;
          enableNvtop = false;
          enableHtop = false;
          enableGtk = false;
          enableQt = false;
          enableWarp = false;
          enableChromium = false;
          enableZed = false;
          enableCava = false;
        };
      };
    };

    package = inputs.caelestia-shell.packages.${pkgs.system}.with-cli.override {
      extraRuntimeDeps = with pkgs; [
        kdePackages.kirigami
        kdePackages.kirigami-addons
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
      ];
    };

    settings = {
      services = {
        smartScheme = true;
      };

      bar = {
        status.showBattery = true;
        persistent = false;
        showOnHover = true;
      };

      general.apps = {
        terminal = ["kitty"];
        audio = ["pavucontrol"];
      };

      paths = {
        wallpaperDir = "~/Pictures/Wallpapers";
      };

      session = {
        commands.logout = ["hyprctl" "dispatch" "exit"];
      };
    };
  };
  programs = {
    zathura = {
      enable = true;
    };
    imv = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    localsend
    #
    # gpu-screen-recorder
    junction
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-red-cursors";
    XCURSOR_SIZE = "24";
  };
}
