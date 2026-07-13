{
  inputs,
  pkgs,
  ...
}: let
  catppuccin-prismlauncher = pkgs.stdenvNoCC.mkDerivation {
    pname = "catppuccin-prismlauncher";
    version = "unstable";

    src = inputs.catppuccin-prismlauncher;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/PrismLauncher
      cp -r themes $out/share/PrismLauncher/themes

      runHook postInstall
    '';
  };
in {
  home.packages = with pkgs; [
    /*
       (prismlauncher.override {
      additionalLibs = [
        libxtst
      ];
      jdks = [
        graalvmPackages.graalvm-ce
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    })
    */

    brave
    kdePackages.ark
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-us
    arrpc
    qbittorrent
    libreoffice
    obsidian
    discover-overlay
    metadata-cleaner
    ff2mpv
    rnote
  ];

  programs.prismlauncher = {
    enable = true;
    package = pkgs.prismlauncher.override {
      additionalLibs = [pkgs.libxtst];
      jdks = with pkgs; [
        graalvmPackages.graalvm-ce
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    };
    extraPackages = [
      catppuccin-prismlauncher
    ];
    settings = {
      ApplicationTheme = "Catppuccin-Mocha";
    };
    icons = [];
  };
}
