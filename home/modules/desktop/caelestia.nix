{
  inputs,
  pkgs,
  ...
}: {
  programs.caelestia = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = [];
    };

    cli = {
      enable = true;
      settings = {
        theme = {
          enable = true;
          enableHypr = true;
          enableMpv = true;
          enableCava = true;
          enableFuzzel = true;
          enableBtop = true;
          enableTerm = false;
          enableDiscord = false;
          enableSpicetify = false;
          enablePandora = false;
          enableNvtop = false;
          enableHtop = false;
          enableGtk = true;
          enableQt = true;
          enableWarp = false;
          enableChromium = false;
          enableZed = false;
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
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-red-cursors";
    XCURSOR_SIZE = "24";
  };
}
