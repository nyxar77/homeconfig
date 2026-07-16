{...}: {
  programs.vesktop = {
    enable = true;
    # package = unstablePkgs.vesktop;
    settings = {
      arRPC = true;
      checkUpdates = true;
      discordBranch = "stable";

      appBadge = true;
      customTitleBar = true;
      discordTitleBar = true;
      disableMinSize = true;
      hardwareAcceleration = true;
      minimizeToTray = true;
      tray = true;

      spellCheckLanguages = ["fr-FR" "en-US"];
    };

    vencord.themes = {
      catppuccin = "@import url('https://catppuccin.github.io/discord/dist/catppuccin-mocha-red.theme.css')";
    };
    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = false;
      notifyAboutUpdates = true;

      enabledThemes = [
        "caelestia.theme.css"
        #"catppuccin.css"
      ];
      useQuickCss = true;

      disableMinSize = true;
      plugins = {
        AnonymiseFileNames.enabled = true;
        # AlwaysAnimate.enabled = true;
        BetterFolders = {
          enabled = true;
          closeOthers = true;
          sidebar = false;
          sidebarAnim = false;
        };
        BetterSessions.enabled = true;
        BetterSettings.enabled = true;
        CallTimer.enabled = true;
        ClearURLs.enabled = true;
        CopyFileContents.enabled = true;
        CopyUserURLs.enabled = true;
        CustomRPC.enabled = true;
        # CustomIdle.enabled = true;
        DisableCallIdle = true;
        FakeNitro.enabled = true;
        FavoriteEmojiFirst.enabled = true;
        FixImagesQuality.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FriendsSince.enabled = true;
        GameActivityToggle.enabled = true;
        GifPaste.enabled = true;
        ImageZoom = {
          enabled = true;
          size = 300;
          zoom = 2.50;
        };
        KeepCurrentChannel.enabled = true;
        LastFMRichPresence.enabled = true;
        MessageLogger = {
          enabled = true;
          ignoreSelf = true;
        };
        MessageLatency.enabled = true;
        MutualGroupDMs.enabled = true;
        NoDevtoolsWarning.enabled = true;
        NoTypingAnimation.enabled = true;
        NoUnblockToJump.enabled = true;
        OpenInApp.enabled = true;
        ReadAllNotificationsButton.enabled = true;
        ReplaceGoogleSearch = {
          enabled = true;
          replacementEngine = "DuckDuckGo";
        };
        ReverseImageSearch.enabled = true;
        ReviewDB.enabled = true;
        SilentTyping.enabled = true;
        ShowConnections.enabled = true;
        SortFriendRequests.enabled = true;
        SpotifyControls.enabled = true;
        ThemeAttributes.enabled = true;
        Translate.enabled = true;
        Unindent.enabled = true;
        ValidReply.enabled = true;
        ValidUser.enabled = true;
        UserVoiceShow.enabled = true;
        ViewIcons.enabled = true;
        VoiceMessages.enabled = true;
        VolumeBooster.enabled = true;
        YoutubeAdblock.enabled = true;
      };
    };
  };
}
