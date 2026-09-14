{ pkgs, unstablePkgs, ... }:
{
  imports = [
    ./gwenview.nix
    ./ninjabrain-bot.nix
    ./readest.nix
  ];

  home.packages = [
    (pkgs.callPackage ./pomotroid.nix { })
  ];

  programs = {
    readest.enable = true;
    gwenview = {
      enable = true;

      settings = {
        General = {
          BackgroundColorMode = "DocumentView::Dark";
          FullScreenBackground = "FullScreenBackground::Black";
          HistoryEnabled = false;
          JPEGQuality = 95;
          SideBarPage = "operations";
        };

        FullScreen.ShowFullScreenThumbnails = false;

        ImageView = {
          AlphaBackgroundMode = "AbstractImageView::AlphaBackgroundCheckBoard";
          MouseWheelBehavior = "MouseWheelBehavior::Zoom";
        };

        ThumbnailView.ThumbnailSize = 192;

        Crop = {
          CropPreserveAspectRatio = true;
          CropShowGridlinesEnabled = true;
        };

        RedEyeReduction.RedEyeReductionDiameter = 99;
        "slide show".loop = true;
        MainWindow.MenuBar = "Disabled";
      };
    };

    ninjabrain-bot = {
      enable = true;
      package = unstablePkgs.ninjabrain-bot;

      settings = {
        always_on_top = true;
        auto_reset = true;
        check_for_updates = false;
        direction_help_enabled = true;
        language_v2 = "en-US";
        mc_version = 0;
        show_angle_errors = true;
        show_angle_updates = true;
        show_nether_coords = true;
        sigma = 0.05;
        size = 0;
        theme = 10;
        translucent = false;
        use_obs_overlay = true;
        view = 1;
      };
    };
  };
}
