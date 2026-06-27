{pkgs, ...}: {
  services.podman = {
    enable = true;
    autoUpdate.enable = false;
  };

  home.packages = with pkgs; [
    podman-compose
  ];
}
