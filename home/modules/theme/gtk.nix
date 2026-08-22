{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 12;
    };

    iconTheme = {
      /*
         name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
      */
      name = "Yaru-blue";
      package = pkgs.yaru-theme;
    };

    /*
       iconTheme = {
      name = "Papirus-Dark";

      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      };
    };
    */
  };

  fonts.fontconfig.enable = true;
}
