{pkgs, ...}: {
  programs = {
    zathura.enable = true;
    imv.enable = true;
  };

  home = {
    packages = with pkgs; [
      localsend
    ];

    sessionVariables = {
      XCURSOR_THEME = "catppuccin-mocha-red-cursors";
      XCURSOR_SIZE = "24";
    };

    file."Pictures/Wallpapers".source = ../../../../assets/Wallpapers;
  };
}
