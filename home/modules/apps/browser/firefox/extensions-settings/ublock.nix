{lib}: {
  userSettings = rec {
    uiTheme = "dark";
    uiAccentCustom = true;
    uiAccentCustom0 = "#8300ff";
    advancedUserEnabled = true;
    cloudStorageEnabled = lib.mkDefault true;
    largeMediaSize = 500;
    popupPanelSections = 31;

    importedLists = [
      "https://filters.adtidy.org/extension/ublock/filters/3.txt"
      "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
    ];

    externalLists = lib.concatStringsSep "\n" importedLists;
  };

  selectedFilterLists = [
    "user-filters"

    # Core uBO
    "ublock-filters"
    "ublock-badware"
    "ublock-privacy"
    "ublock-quick-fixes"
    "ublock-unbreak"

    # Ads + privacy
    "easylist"
    "easyprivacy"

    # Security
    "urlhaus-1"
    "block-lan"
    "plowe-0"

    # Decent UI cleanup, without stacking every ecosystem
    "ublock-annoyances"
    "easylist-annoyances"
    "fanboy-cookiemonster"
  ];
  hostnameSwitchesString = lib.concatStringsSep "\n" [
    "no-csp-reports: * true"
    "no-cosmetic-filtering: * false"
  ];
}
