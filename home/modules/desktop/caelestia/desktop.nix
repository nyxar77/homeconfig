{ config, pkgs, ... }:
let
  wallpaperDir = "${config.home.homeDirectory}/Pictures/Wallpapers";
  excludedWallpapers = [
    "galaxies.png"
    "unreal.png"
    "purple-pixel-art-wallpapers.jpg"
  ];
  selectedWallpapers = builtins.filter (name: !(builtins.elem name excludedWallpapers)) (
    builtins.attrNames (builtins.readDir ../../../../assets/Wallpapers)
  );
in
{
  programs = {
    zathura = {
      enable = true;
      options = {
        # Lecture
        adjust-open = "width";
        scroll-page-aware = true;
        scroll-wrap = false;
        scroll-step = 50;

        # Zoom
        zoom-step = 10;
        zoom-center = true;

        # Espacement entre les pages
        page-v-padding = 8;
        page-h-padding = 8;

        # Copier avec Ctrl+V normalement
        selection-clipboard = "clipboard";

        # Interface
        statusbar-home-tilde = true;
        statusbar-page-percent = true;
        window-title-basename = true;
        window-title-page = true;

        # Historique/bookmarks
        database = "sqlite";
      };
    };
    imv.enable = true;
  };

  home = {
    packages = with pkgs; [
      lxqt.pavucontrol-qt
    ];

    file = {
      "Pictures/Wallpapers".source = ../../../../assets/Wallpapers;
    }
    // builtins.listToAttrs (
      map (name: {
        name = "Pictures/CaelestiaWallpapers/${name}";
        value.source = config.lib.file.mkOutOfStoreSymlink "${wallpaperDir}/${name}";
      }) selectedWallpapers
    );
  };
}
