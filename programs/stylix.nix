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

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/Catppuccin-Macho.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    base16Scheme = {
      base00 = "#211e2a";
      base01 = "#2c2737";
      base02 = "#3f3951";
      base03 = "#6e6780";
      base04 = "#8a829e";
      base05 = "#e4dee9";
      base06 = "#f2e8f0";
      base07 = "#ffffff";
      base08 = "#e965a5";
      base09 = "#f4b870";
      base0A = "#ebde76";
      base0B = "#b1f2a7";
      base0C = "#b3f4f3";
      base0D = "#95a6f4";
      base0E = "#ff79c6";
      base0F = "#bd93f9";
    };

    targets = {
      firefox = {
        enable = false;
      };

      vesktop.enable = true;
      spicetify.enable = false;
      kitty.enable = true;
      tmux.enable = true;
      neovim.enable = false;
      mpv.enable = true;
    };
  };
}
