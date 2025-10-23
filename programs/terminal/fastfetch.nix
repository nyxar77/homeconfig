{pkgs, ...}: {
  programs.fastfetch = {
    enable = true;
    settings = pkgs.lib.importJSON ./config.jsonc;
    # settings = pkgs.lib.strings.fromJSON (pkgs.lib.readFile ./defaultfastfetch.jsonc);
  };
}
