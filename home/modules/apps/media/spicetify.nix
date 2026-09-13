{
  pkgs,
  spicetify-nix,
  ...
}:
{
  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.hazy;
      # theme = spicePkgs.themes.bloom;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
        keyboardShortcut
        copyToClipboard
        history
        betterGenres
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
        historyInSidebar
      ];
      enabledSnippets = with spicePkgs.snippets; [
        circularAlbumArt
        newHoverPanel
        dynamicLeftSidebar
        spinningCdCoverArt
        pointer
      ];
    };
}
