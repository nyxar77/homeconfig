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
    theme = spicePkgs.themes.retroBlur;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
    ];
  };
}
