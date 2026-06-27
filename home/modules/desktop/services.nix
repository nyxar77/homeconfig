{pkgs, ...}: {
  services.kdeconnect = {
    enable = true;
    indicator = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
  services.gromit-mpx = {
    enable = true;
  };
}
