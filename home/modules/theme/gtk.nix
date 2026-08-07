{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 12;
    };

    iconTheme = {
      name = "Papirus-Dark";

      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      };
    };
  };

  fonts.fontconfig.enable = true;
}
