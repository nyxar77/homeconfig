{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 14;
    };

    iconTheme = {
      name = "Papirus-Dark";

      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      };
    };
  };
}
