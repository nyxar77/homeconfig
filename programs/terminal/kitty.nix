{lib, ...}: {
  programs.kitty = lib.mkForce {
    enable = true;
    enableGitIntegration = true;
    settings = {
      confirm_os_window_close = 1;
      dynamic_background_opacity = true;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      # background_opacity = "0.7";
      opacity_style = "flat";
      maximized = "yes";
      padding = 10;
      width = "20²0";
      background_blur = 0;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };
    };
  };
}
