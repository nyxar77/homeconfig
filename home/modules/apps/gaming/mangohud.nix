{...}: {
  programs.mangohud.enable = true;

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    legacy_layout=false

    fps
    frame_timing=1
    gpu_stats
    gpu_temp
    gpu_load_change
    gpu_load_value=50,90
    cpu_stats
    cpu_temp
    cpu_load_change
    cpu_load_value=50,90
    vram
    ram

    position=top-left
    font_size=14
    font_size_text=14
    round_corners=6
    background_alpha=0.50
    alpha=1.0
    background_color=1e1e2e
    text_color=cdd6f4
    text_outline_color=1e1e2e

    gpu_color=a6e3a1
    cpu_color=89b4fa
    vram_color=94e2d5
    ram_color=cba6f7
    frametime_color=a6e3a1
    gpu_load_color=a6e3a1,f9e2af,f38ba8
    cpu_load_color=a6e3a1,f9e2af,f38ba8
    fps_color=a6e3a1,f9e2af,f38ba8

    toggle_hud=F12
  '';
}
