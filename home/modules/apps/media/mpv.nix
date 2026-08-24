{
  pkgs,
  unstablePkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;

    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        modernz
        quality-menu
        sponsorblock-minimal
        mpris
        thumbfast
      ];

      mpv-unwrapped = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
        ffmpeg = pkgs.ffmpeg-full;
      };
    };

    config = {
      profile = "fast";
      ytdl-format = "bv[height<=1080]+ba/best";
      save-watch-history = "yes"; # press <gh>
      hwdec = "auto-safe";
      fullscreen = "no";
      window-scale = 0.5;
      speed = 1.15;
      save-position-on-quit = "yes";
      watch-later-options = "start";
      interpolation = "no";
      video-sync = "audio";
      scale = "bilinear";
      cscale = "bilinear";
      dscale = "bilinear";
      keep-open = "always";
      deband = "no";
      vo = "gpu-next";
      input-default-bindings = "yes";
      osd-font = "CaskaydiaCove NF";
      script-opts = "ytdl_hook-ytdl_path=yt-dlp";
      screenshot-directory = "~/Pictures/Screenshots";

      framedrop = "vo";
      correct-downscaling = "no";
      sigmoid-upscaling = "no";
      hdr-compute-peak = "no";
    };

    bindings = {
      "]" = "add speed 0.05";
      "[" = "add speed -0.05";
      BS = "set speed 1.15";
      UP = "seek 5";
      DOWN = "seek -5";
      F = "script-binding quality_menu/video_formats_toggle";
      "ALT+F" = "script-binding quality_menu/audio_formats_toggle";
      "CTRL+R" = "script-binding reset-playback/reset";
      /*
           "CTRL+1" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"'';
        "CTRL+2" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"'';
        "CTRL+3" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"'';
        "CTRL+4" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"'';
        "CTRL+5" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"'';
        "CTRL+6" = ''no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"'';
        "CTRL+0" = ''no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"'';
      */
    };
  };

  programs.yt-dlp = {
    enable = true;
    package = unstablePkgs.yt-dlp;
  };

  xdg.configFile."mpv/scripts/watch-later.lua".text = ''
    local minimum_duration = 30
    local expiry_minutes = 21 * 24 * 60
    local cleaned = false

    local function watch_later_dir()
      local dir = mp.get_property("watch-later-dir")
      if dir == nil or dir == "" then
        dir = mp.command_native({
          name = "expand-path",
          args = { "~~/watch_later" },
        })
      end
      return dir
    end

    local function clean_expired_entries()
      if cleaned then return end
      cleaned = true

      mp.command_native({
        name = "subprocess",
        args = {
          "find",
          watch_later_dir(),
          "-type",
          "f",
          "-mmin",
          "+" .. expiry_minutes,
          "-delete",
        },
        playback_only = false,
      })
    end

    local function update_resume_behavior(_, duration)
      mp.set_property_bool(
        "save-position-on-quit",
        duration ~= nil and duration > minimum_duration
      )
    end

    mp.register_event("start-file", clean_expired_entries)
    mp.register_event("start-file", function()
      mp.set_property_bool("save-position-on-quit", false)
    end)
    mp.observe_property("duration", "native", update_resume_behavior)
  '';

  xdg.configFile."mpv/scripts/reset-playback.lua".text = ''
    local defaults = {
      ["speed"] = "1.15",
      ["audio-delay"] = "0",
      ["sub-delay"] = "0",
      ["sub-pos"] = "100",
      ["sub-scale"] = "1",
      ["video-zoom"] = "0",
      ["video-pan-x"] = "0",
      ["video-pan-y"] = "0",
      ["video-rotate"] = "0",
      ["video-aspect-override"] = "-1",
    }

    local function reset()
      for property, value in pairs(defaults) do
        mp.set_property(property, value)
      end

      mp.osd_message("Playback adjustments reset")
    end

    mp.add_key_binding(nil, "reset", reset)
  '';
}
