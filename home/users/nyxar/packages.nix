{pkgs, ...}: {
  home.packages = with pkgs; [
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

    brave
    chromium
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
}
