{pkgs, ...}: {
  services.kdeconnect = {
    enable = false;
    indicator = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
  services.gromit-mpx = {
    enable = false;
  };
}
