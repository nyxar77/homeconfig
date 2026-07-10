{
  pkgs,
  config,
  stylix,
  ...
}: {
  imports = [stylix.homeModules.stylix];
  stylix = {
    enable = true;
    autoEnable = true;
    image = null;
    polarity = "dark";
    # fonts.sizes = 10;
    # icons.enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets = {
      qt = {
        enable = false;
        platform = "qtct";
      };
      gtk.enable = false;
      tmux.enable = false;
      starship.enable = false;
      mpv.enable = false;
      cava.enable = false;
      mangohud.enable = false;
      fzf.enable = false;
      hyprland.enable = false;
      firefox.enable = false;
      vesktop.enable = false;
      spicetify.enable = false;
      neovim.enable = false;
      bat.enable = false;
      kitty.enable = true;
    };
  };
}
