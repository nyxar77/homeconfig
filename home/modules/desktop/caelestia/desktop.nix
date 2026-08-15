{pkgs, ...}: {
  programs = {
    zathura.enable = true;
    imv.enable = true;
  };

  home = {
    packages = with pkgs; [
      localsend
      lxqt.pavucontrol-qt
    ];

    file."Pictures/Wallpapers".source = ../../../../assets/Wallpapers;
  };
}
