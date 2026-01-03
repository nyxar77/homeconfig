{
  pkgs,
  unstablePkgs,
  ...
}: {
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          modernz
          sponsorblock-minimal
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
          ffmpeg = pkgs.ffmpeg-full;
        };
      }
    );

    # scripts = with pkgs.mpvScripts; [modernz sponsorblock-minimal];

    config = {
      profile = "fast";
      # ytdl-format = "bv[codec=av01]/bv[codec=vp9]/bv[ext=mp4]+ba/best";
      ytdl-format = "bv[height<=1080]+ba/best";
      hwdec = "auto";
      fullscreen = "yes";
      window-scale = 0.5;
      speed = 1.15;
      save-position-on-quit = "no";
      watch-later-options = "start";
      interpolation = "no";
      video-sync = "audio";
      scale = "bilinear";
      keep-open = "always";
      deband = "no";
      vo = "gpu-next";
      input-default-bindings = "yes";
      script-opts = "ytdl_hook-ytdl_path=yt-dlp";
      screenshot-directory = "~/Pictures/Screenshots";
    };

    bindings = {
      "]" = "add speed 0.05";
      "[" = "add speed -0.05";
      BS = "set speed 1.15";
      UP = "seek 10";
      DOWN = "seek -10";
      "CTRL+1" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"'';
      "CTRL+2" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"'';
      "CTRL+3" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"'';
      "CTRL+4" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"'';
      "CTRL+5" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"'';
      "CTRL+6" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"'';
      "CTRL+0" = ''no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"'';
    };
  };

  programs.yt-dlp = {
    enable = true;
    package = unstablePkgs.yt-dlp;
  };
}
