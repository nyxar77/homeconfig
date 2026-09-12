{ pkgs, unstablePkgs, ... }: {
  imports = [
    ./anki.nix
    ./ninjabrain-bot.nix
    ./nautilus.nix
    ./readest.nix
  ];

  home.packages = [
    (pkgs.callPackage ./pomotroid.nix { })
  ];

  programs.readest = {
    enable = true;
  };

  programs.ninjabrain-bot = {
    enable = true;
    package = unstablePkgs.ninjabrain-bot;

    settings = {
      alwaysOnTop = true;
      autoReset = true;
      checkForUpdates = false;
      directionHelp = true;
      language = "en-US";
      minecraftVersion = "1.9-1.18";
      showAngleErrors = true;
      showAngleUpdates = true;
      showNetherCoordinates = true;
      sigma = 0.05;
      windowSize = "small";
      theme = 10;
      translucentWindow = false;
      useObsOverlay = true;
      view = "detailed";
    };
  };
}
