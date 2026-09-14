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
