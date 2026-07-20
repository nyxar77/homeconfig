{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 13;
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
