{
  pkgs,
  unstablePkgs,
  ...
}: {
  home.packages = [
    # (pkgs.callPackage ../../packages/ninjabrain-bot.nix {})
    unstablePkgs.ninjabrain-bot
  ];
}
