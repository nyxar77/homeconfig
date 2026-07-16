{
  pkgs,
  spicetify-nix,
  ...
}: {
  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;
    theme = spicePkgs.themes.hazy;
    # theme = spicePkgs.themes.defaultDynamic;
    /*
    theme = {
      name = "";
      src = pkgs.fetchFromGithub {};
      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      homeConfig = true;
      overwriteAssets = false;
    };
    */
    # colorScheme = "";
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
  };
}
