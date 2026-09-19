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
    readest = {
      enable = true;

      settings = {
        keepLogin = false;
        autoUpload = false;
        alwaysOnTop = false;
        openBookInNewWindow = false;
        alwaysShowStatusBar = false;
        alwaysInForeground = false;
        autoCheckUpdates = false;
        screenWakeLock = false;
        screenBrightness = -1;
        autoScreenBrightness = true;
        openLastBooks = false;
        autoImportBooksOnOpen = false;
        telemetryEnabled = false;
        discordRichPresenceEnabled = true;

        libraryViewMode = "grid";
        librarySortBy = "updated";
        librarySortAscending = false;
        libraryGroupBy = "group";
        libraryCoverFit = "crop";
        libraryAutoColumns = true;
        libraryColumns = 6;

        metadataSeriesCollapsed = false;
        metadataOthersCollapsed = false;
        metadataDescriptionCollapsed = false;
        pinCodeEnabled = false;
        customDictionaries = [ ];

        dictionarySettings = {
          providerOrder = [
            "builtin:wiktionary"
            "builtin:wikipedia"
          ];
          providerEnabled = {
            "builtin:wiktionary" = true;
            "builtin:wikipedia" = true;
          };
        };

        syncCategories = {
          book = true;
          progress = true;
          note = true;
          dictionary = true;
          font = true;
          texture = true;
          opds_catalog = true;
          settings = true;
        };

        globalReadSettings = {
          sideBarWidth = "15%";
          isSideBarPinned = true;
          notebookWidth = "25%";
          isNotebookPinned = false;
          notebookActiveTab = "notes";
          autohideCursor = true;
          translationProvider = "deepl";
          translateTargetLang = "EN";
          customThemes = [ ];
          highlightStyle = "highlight";
          highlightStyles = {
            highlight = "yellow";
            underline = "green";
            squiggly = "blue";
          };
          customHighlightColors = {
            red = "#f87171";
            yellow = "#facc15";
            green = "#4ade80";
            blue = "#60a5fa";
            violet = "#a78bfa";
          };
          userHighlightColors = [ ];
          defaultHighlightLabels = { };
          customTtsHighlightColors = [
            "#e01e1e"
            "#ea7373"
          ];
        };

        globalViewSettings = {
          marginTopPx = 44;
          marginBottomPx = 44;
          marginLeftPx = 16;
          marginRightPx = 16;
          compactMarginTopPx = 16;
          compactMarginBottomPx = 16;
          compactMarginLeftPx = 16;
          compactMarginRightPx = 16;
          gapPercent = 5;
          scrolled = false;
          noContinuousScroll = false;
          disableClick = false;
          fullscreenClickArea = false;
          swapClickArea = false;
          disableDoubleClick = false;
          volumeKeysToFlip = false;
          maxColumnCount = 2;
          maxInlineSize = 720;
          maxBlockSize = 1886;
          writingMode = "auto";
          vertical = false;
          rtl = false;
          scrollingOverlap = 0;
          allowScript = false;
          hideScrollbar = false;
          zoomLevel = 100;
          paragraphMargin = 0.6;
          lineHeight = 1.4;
          wordSpacing = 0;
          letterSpacing = 0;
          textIndent = 0;
          fullJustification = true;
          hyphenation = true;
          theme = "light";
          backgroundTextureId = "night-sky";
          backgroundOpacity = 0.4;
          backgroundSize = "cover";
          highlightOpacity = 0.4;
          codeHighlighting = true;
          codeLanguage = "auto-detect";
          userStylesheet = "";
          userUIStylesheet = "";
          overrideFont = false;
          overrideLayout = false;
          overrideColor = true;
          useBookLayout = false;
          zoomMode = "fit-page";
          spreadMode = "auto";
          keepCoverSpread = true;
          invertImgColorInDark = false;
          applyThemeToPDF = false;
          serifFont = "Bitter";
          sansSerifFont = "Roboto";
          monospaceFont = "Consolas";
          defaultFont = "Serif";
          defaultCJKFont = "LXGW WenKai GB Screen";
          defaultFontSize = 17;
          minimumFontSize = 10;
          fontWeight = 400;
          replaceQuotationMarks = true;
          convertChineseVariant = "none";
          sideBarTab = "toc";
          uiLanguage = "";
          sortedTOC = false;
          doubleBorder = false;
          borderColor = "red";
          showHeader = true;
          showFooter = true;
          showBarsOnScroll = false;
          showRemainingTime = false;
          showRemainingPages = false;
          showProgressInfo = true;
          showCurrentTime = false;
          showCurrentBatteryStatus = false;
          showBatteryPercentage = true;
          use24HourClock = false;
          tapToToggleFooter = false;
          showMarginsOnScroll = false;
          showPaginationButtons = false;
          progressStyle = "fraction";
          progressInfoMode = "all";
          animated = false;
          isEink = false;
          isColorEink = false;
          paragraphMode.enabled = false;
          readingRulerEnabled = false;
          readingRulerLines = 2;
          readingRulerOpacity = 0.4;
          readingRulerColor = "transparent";
          ttsRate = 1.3;
          ttsVoice = "";
          ttsLocation = "";
          showTTSBar = false;
          ttsHighlightOptions = {
            style = "highlight";
            color = "#ea7373";
          };
          ttsMediaMetadata = "sentence";
          screenOrientation = "auto";
          enableAnnotationQuickActions = true;
          annotationQuickAction = null;
          copyToNotebook = false;
          noteExportConfig = {
            includeTitle = true;
            includeAuthor = true;
            includeDate = true;
            includeChapterTitles = true;
            includeQuotes = true;
            includeNotes = true;
            includePageNumber = true;
            includeTimestamp = false;
            includeChapterSeparator = false;
            noteSeparator = "\n\n";
            useCustomTemplate = false;
            customTemplate = "";
            exportAsPlainText = false;
          };
          isGlobal = true;
          translationEnabled = false;
          translationProvider = "google";
          translateTargetLang = "en";
          showTranslateSource = true;
          ttsReadAloudText = "both";
        };
      };
    };

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
