{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../packages/ninjabrain-bot.nix {})
  ];
}
