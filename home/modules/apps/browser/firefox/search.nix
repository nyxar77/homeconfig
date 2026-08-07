{pkgs}: {
  force = true;
  default = "ddg";
  privateDefault = "ddg";
  order = ["ddg" "google" "Nix Packages" "Nix Options" "Nix Wiki" "HM Options"];
  engines = {
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            /*
               {
              name = "channel";
              value = "unstable";
            }
            */
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np"];
    };

    "Nix Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            /*
               {
              name = "channel";
              value = "unstable";
            }
            */
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
      definedAliases = ["@no"];
    };

    "NixOS Wiki" = {
      urls = [
        {
          template = "https://wiki.nixos.org/w/index.php";
          params = [
            {
              name = "search";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
      definedAliases = ["@nw"];
    };

    "Noogle" = {
      urls = [
        {
          template = "https://noogle.dev";
          params = [
            {
              name = "term";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@ng"];
    };
    "HM Options" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://home-manager-options.extranix.com/images/favicon.png";
      definedAliases = ["@hm"];
    };

    "Google Translate" = {
      urls = [
        {
          template = "https://translate.google.com/?sl=fr&tl=en&text={searchTerms}&op=translate";
          params = [
            {
              name = "text";
              value = "{searchTerms}";
            }
            {
              name = "tl";
              value = "en";
            }
            {
              name = "sl";
              value = "fr";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://translate.google.com/favicon.ico";
      definedAliases = ["@tr"];
    };

    bing.metaData.hidden = true;
    perplexity.metaData.hidden = true;
    wikipedia.metaData.hidden = true;
    google.metaData.alias = "@g";
  };
}
