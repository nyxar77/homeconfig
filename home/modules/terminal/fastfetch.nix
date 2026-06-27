{pkgs, ...}: {
  programs.fastfetch = {
    enable = true;
    settings = pkgs.lib.importJSON ./config.jsonc;
  };
}
