{ config, ... }: {
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    homeFlake = "${config.home.homeDirectory}/.config/home-manager";

    clean.enable = false;
  };
}
