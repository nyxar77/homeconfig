{...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pipewire";
      smoothing.noise_reduction = 88;
      color = {
        background = "default";
        foreground = "default";
        gradient_color_1 = "#7D59B3";
        gradient_color_2 = "#8F6AA7";
        gradient_color_3 = "#A17B9B";
        gradient_color_4 = "#B38C8F";
        gradient_color_5 = "#C59D83";
        gradient_color_6 = "#D7AE77";
        gradient_color_7 = "#E9BF6B";
        gradient_color_8 = "#FBD05F";
      };
    };
  };
}
