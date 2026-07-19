{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;

    defaultApplicationPackages = with pkgs; [
      neovim
      imv
      kdePackages.ark
      zathura
      libreoffice
      nautilus
      loupe
      # papers
      mpv
      firefox
    ];

    defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
    };
  };
}
