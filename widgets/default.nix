{pkgs, ...}: {
  imports = [./ags.nix];
  home.packages = with pkgs; [
    gtk4
  ];
}
