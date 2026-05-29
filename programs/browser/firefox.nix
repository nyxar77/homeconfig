{
  lib,
  pkgs,
  config,
  ...
}: {
  /*
     home.file.".mozilla/firefox/nyxar77/search.json.mozlz4".force = lib.mkForce true;
  home.file.".mozilla/firefox/dev77/search.json.mozlz4".force = lib.mkForce true;
  */
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "fr-FR"];
    configPath = "${config.xdg.configHome}/.mozilla/firefox";

    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration pkgs.ff2mpv];

    profiles.nyxar77 = {
      isDefault = true;
      search = import ./search.nix {inherit pkgs;};
      extensions = import ./extensions.nix {inherit pkgs lib;};
      settings = import ./settings.nix;
    };

    profiles.dev77 = {
      isDefault = false;
      id = 1;
      search = import ./search.nix {inherit pkgs;};
      settings = import ./settings.nix;
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          stylus
          firefox-color
          ublock-origin
          privacy-badger
          darkreader
          keepassxc-browser
          buster-captcha-solver
          sponsorblock
          clearurls
          videospeed
          nicothin-space
          translate-web-pages
          react-devtools
          localcdn
          auto-tab-discard
        ];
        force = true;
        settings = let
          stgs = ./extensions-settings;
        in {
          "uBlock0@raymondhill.net".settings = import (stgs + /ublock.nix) {inherit lib;};
        };
      };
    };

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      BlockAboutConfig = false;
      DefaultDownloadDirectory = "\${home}/Downloads";

      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = false;
      DisableMasterPasswordCreation = false;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      DisablePasswordManage = true;
    };
  };
}
