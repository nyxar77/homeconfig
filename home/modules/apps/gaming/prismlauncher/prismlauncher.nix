{
  unstablePkgs,
  pkgs,
  ...
}:
{
  home.packages = [
    # unstablePkgs.ninjabrain-bot
  ];
  programs.prismlauncher = {
    enable = true;
    package = pkgs.prismlauncher.override {
      additionalLibs = with pkgs; [
        libxtst
        libxkbcommon
        libX11
        libXtst
        libxcb
        libXt
        libXinerama
      ];
      jdks = with pkgs; [
        graalvmPackages.graalvm-ce
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    };
    extraPackages = [ ];
    settings = {
      ApplicationTheme = "caelestia-breeze";
      IconTheme = "iOS";
      ShowConsole = false;
      ShowConsoleOnError = true;
      AutoCloseConsole = false;
      EnableMangoHud = true;
      MaxMemAlloc = 6144;
      MinMemAlloc = 896;
      Language = "en_US";
    };

    icons = [
      ./icons/mcsr-icon.png
      ./icons/herobrine_legacy.png
      ./icons/minecraft-story-mode.png
    ];
  };
}
