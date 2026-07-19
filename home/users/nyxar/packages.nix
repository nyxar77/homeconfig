{pkgs, ...}: {
  imports = [./prismlauncher/prismlauncher.nix];
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
    obsidian
    discover-overlay
    metadata-cleaner
    ff2mpv
    rnote
  ];
}
