{
  lib,
  pkgs,
  ...
}: {
  programs.kitty = lib.mkForce {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    enableGitIntegration = true;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 1;
      dynamic_background_opacity = true;
      scrollback_lines = 10000;
      update_check_interval = 0;
      term = "xterm-kitty";
      background_opacity = "0.75";
      opacity_style = "flat";
      maximized = "yes";
      padding = 10;
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      copy_on_select = "clipboard";
      strip_trailing_spaces = "smart";
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      selection_background = "#ebde76";
      selection_foreground = "#211e2a";
      cursor = "#e965a5";
      cursor_text_color = "#211e2a";
      background_blur = 0;
      remember_window_size = "yes";
      /*
         background = "#282433";
      foreground = "#eee9fc";
      selection_background = "#3f3a50";
      selection_foreground = "#eee9fc";
      url_color = "#e965a5";
      cursor = "#eee9fc";

      cursor_text_color = "#211e2a";
      wayland_titlebar_color = "#211e2a";

      # Tabs
      active_tab_background = "#e965a5";
      active_tab_foreground = "#eee0fc";
      active_border_color = "#6e6780";
      inactive_tab_background = "#3f3a50";
      inactive_tab_foreground = "#e965a5";
      inactive_border_color = "#2c2737";
      tab_bar_background = "#2c2737";

      #: black
      color0 = "#282433";
      #color8 #3f3951
      color8 = "#938aad";

      #: red
      color1 = "#e965a5";
      color9 = "#e965a5";

      #: green
      color2 = " #b1f2a7";
      color10 = "#b1f2a7";

      #: yellow
      color3 = " #ebde76";
      color11 = "#ebde76";

      #: blue
      color4 = " #b1baf4";
      color12 = "#b1baf4";

      #: magenta
      color5 = " #e192ef";
      color13 = "#e192ef";

      #: cyan
      color6 = " #b3f4f3";
      color14 = "#b3f4f3";

      #: white
      color7 = " #eee9fc";
      color15 = "#eee9fc";

      color16 = "#f4b870";
      color17 = "#bd93f9";
      color18 = "#2c2737";
      color19 = "#3f3951";
      color20 = "#8a829e";
      color21 = "#f2e8f0";
      */
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      # package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };

    # themeFile = "Catppuccin-Macchiato";
  };
}
