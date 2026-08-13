{pkgs, ...}: {
  programs = {
    zathura.enable = true;
    imv.enable = true;
  };

  home = {
    packages = with pkgs; [
      localsend
    ];

    file."Pictures/Wallpapers".source = ../../../../assets/Wallpapers;
  };
}
