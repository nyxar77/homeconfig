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
      IconTheme = "iOS";
      ShowConsole = false;
      ShowConsoleOnError = true;
      AutoCloseConsole = false;
      EnableMangoHud = true;
      MaxMemAlloc = 6144;
      MinMemAlloc = 896;
      Language = "en_US";
    };
    icons = [];
  };
}
