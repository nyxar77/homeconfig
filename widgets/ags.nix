{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  home.packages = [inputs.astal.packages.${pkgs.system}.io];

  programs.ags = {
    enable = true;
    # extraPackages = with pkgs; [
    # ];
  };
}
