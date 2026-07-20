{pkgs, ...}: let
  braveNoBackground = pkgs.symlinkJoin {
    name = "brave-no-background";
    paths = [pkgs.brave];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram "$out/bin/brave" --add-flags "--disable-background-mode"
    '';
  };
in {
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

    braveNoBackground
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
