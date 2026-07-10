{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;

    defaultApplicationPackages = with pkgs; [
      kdePackages.ark
      loupe
      papers
      mpv
      firefox
      nautilus
    ];

    defaultApplications = {
      # Seulement les exceptions, si nécessaire.
    };
  };
}
