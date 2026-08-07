{
  config,
  pkgs,
  ...
}: let
  generatedThemeDir = "${config.xdg.stateHome}/caelestia/theme";
in {
  xdg = {
    configFile."caelestia/templates/prismlauncher.json".text = ''
      {
        "name": "Caelestia Breeze",
        "widgets": "Breeze",
        "colors": {
          "Window": "#{{ surface.hex }}",
          "WindowText": "#{{ onSurface.hex }}",
          "Base": "#{{ surfaceContainerLowest.hex }}",
          "AlternateBase": "#{{ surfaceContainerLow.hex }}",
          "ToolTipBase": "#{{ inverseSurface.hex }}",
          "ToolTipText": "#{{ inverseOnSurface.hex }}",
          "Text": "#{{ onSurface.hex }}",
          "Button": "#{{ surfaceContainerHighest.hex }}",
          "ButtonText": "#{{ onSurface.hex }}",
          "BrightText": "#{{ error.hex }}",
          "Link": "#{{ primary.hex }}",
          "Highlight": "#{{ primary.hex }}",
          "HighlightedText": "#{{ onPrimary.hex }}",
          "fadeAmount": 0.42,
          "fadeColor": "#{{ surface.hex }}"
        },
        "logColors": {
          "Message": "#{{ onSurface.hex }}",
          "Launcher": "#{{ primary.hex }}",
          "Debug": "#{{ onSurfaceVariant.hex }}",
          "Warning": "#{{ tertiary.hex }}",
          "Error": "#{{ error.hex }}",
          "Fatal": "#{{ onErrorContainer.hex }}",
          "MessageHighlight": "#{{ surfaceContainerLow.hex }}",
          "LauncherHighlight": "#{{ primaryContainer.hex }}",
          "DebugHighlight": "#{{ surfaceContainer.hex }}",
          "WarningHighlight": "#{{ tertiaryContainer.hex }}",
          "ErrorHighlight": "#{{ errorContainer.hex }}",
          "FatalHighlight": "#{{ errorContainer.hex }}"
        }
      }
    '';

    dataFile."PrismLauncher/themes/caelestia-breeze/theme.json".source =
      config.lib.file.mkOutOfStoreSymlink "${generatedThemeDir}/prismlauncher.json";
  };

  programs.prismlauncher = {
    enable = true;
    package =
      (pkgs.prismlauncher.override {
        additionalLibs = [pkgs.libxtst];
        jdks = with pkgs; [
          graalvmPackages.graalvm-ce
          jdk25
          jdk21
          jdk17
          jdk8
        ];
      }).overrideAttrs (old: {
        buildInputs = (old.buildInputs or []) ++ [pkgs.kdePackages.breeze];
      });
    extraPackages = [];
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

    icons = [./icons/mcsr-icon.png ./icons/herobrine_legacy ./icons/minecraft-story-mode.png];
  };
}
