{
  lib,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "fr-FR"];

    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration pkgs.ff2mpv];

    profiles.nyxar77 = {
      search = import ./search.nix {inherit pkgs;};
      extensions = import ./extensions.nix {inherit pkgs lib;};
      settings = import ./settings.nix;
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
