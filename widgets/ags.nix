{
  inputs,
  pkgs,
  ...
}: let
  astal = inputs.astal.packages.${pkgs.system};
in {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    extraPackages = with astal; [
      auth
      tray
      apps
      mpris
      greet
      notifd
      network
      battery
      hyprland
      bluetooth
      wireplumber
      powerprofiles
    ];
  };
}
