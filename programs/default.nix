{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./terminal
    ./ui
    ./spicetify.nix
    ./stylix.nix
    ./mpv.nix
  ];
}
