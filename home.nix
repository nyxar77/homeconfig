{
  config,
  pkgs,
  inputs,
  ...
}: {
    
  imports = [
    ./programs
    ./devtools.nix
    ./services
    ./widgets
  ]; 

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nyxar";
  home.homeDirectory = "/home/nyxar";
  nixpkgs.config = {
    #allowBroken = true;
    allowUnfree = true;
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  programs.waybar.enable = true;
  programs.mangohud.enable = true;
  home.file.".config/mangohud/MangoHud.conf".text = ''
    toggle_fps_limit=F1
    vsync=3
    gl_vsync=0
    legacy_layout=false
    gpu_stats
    gpu_temp
    gpu_load_change
    gpu_load_value=50,90
    gpu_load_color=FFFFFF,FF7800,CC0000
    gpu_text=GPU
    cpu_stats
    cpu_temp
    cpu_load_change
    core_load_change
    cpu_load_value=50,90
    cpu_load_color=FFFFFF,FF7800,CC0000
    cpu_color=2e97cb
    cpu_text=CPU
    io_color=a491d3
    vram
    vram_color=ad64c1
    ram
    ram_color=c26693
    fps
    engine_color=eb5b5b
    gpu_color=2e9762
    wine_color=eb5b5b
    frame_timing=1
    frametime_color=00ff00
    media_player_color=ffffff
    background_alpha=0.4
    font_size=24
    background_color=020202
    position=top-left
    text_color=ffffff
    round_corners=7
    toggle_hud=Shift_R+F12
    toggle_logging=Shift_L+F2
    upload_log=F5
    output_folder=/home/nyxar
    media_player_name=spotify
  '';
  programs.obs-studio.enable = true;
  programs.vim.enable = true;
  home.packages = with pkgs; [
    lan-mouse
    brave
    chromium
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-us
    arrpc
    blender-hip
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk21
      ];
    })
    qbittorrent
    libreoffice
    obsidian
    discover-overlay
    metadata-cleaner
    ff2mpv
    yt-dlp

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nyxar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    EDITOR = "nvim";
    VISUAL = "nvim";
    USER = "nyxar";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
