{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "fr-FR"];
    preferences = {
      "browser.tabs.tabmanager.enabled" = false;
    };
    nativeMessagingHosts = {
      ff2mpv = true;
      packages = [pkgs.plasma-browser-integration];
    };

    profiles.baryon.search = {
      default = "ddg";
      privateDefault = "ddg";
      order = ["ddg" "google" "nix-packages" "nixos-wiki" "home-manager"];
      engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };

        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
          iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          definedAliases = ["@nw"];
        };
        noogle = {
          name = "Noogle";
          urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
          iconMapObj."16" = "https://noogle.dev/favicon.png";
          definedAliases = ["@ng"];
        };
        home-manager = {
          name = "hm Options";
          urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
          iconMapObj."16" = "https://home-manager-options.extranix.com/images/favicon.png";
          definedAliases = ["@hm"];
        };

        bing.metaData.hidden = true;
        google.metaData.alias = "@g"; # builtin engines only support specifying one additional alias
      };
    };

    profiles.baryon.extensions = {
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];
      settings."uBlock0@raymondhill.net".settings = {
        selectedFilterLists = [
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-unbreak"
          "ublock-quick-fixes"
        ];
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
    };
  };
}
