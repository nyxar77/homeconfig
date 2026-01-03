{unstablePkgs, ...}: {
  programs.vesktop = {
    enable = true;
    package = unstablePkgs.vesktop;
    settings = {
      appBadge = true;
      arRPC = true;
      checkUpdates = true;
      customTitleBar = true;
      disableMinSize = true;
      discordTitleBar = true;
      minimizeToTray = true;
      tray = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };
    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = true;
      useQuickCss = true;
      disableMinSize = true;
      plugins = {
        MessageLogger = {
          enabled = true;
          ignoreSelf = true;
        };
        FakeNitro.enabled = true;
        AnonymiseFileNames.enabled = true;
        BetterSessions.enabled = true;
        BetterSettings.enabled = true;
        CallTimer.enabled = true;
        ClearURLs.enabled = true;
        CustomRPC.enabled = true;
        # CustomIdle.enabled = true;
        DisableCallIdle = true;
        FavoriteEmojiFirst.enabled = true;
        FixImagesQuality.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FriendsSince.enabled = true;
        GameActivityToggle.enabled = true;
        GifPaste.enabled = true;
        ImageZoom.enabled = true;
        KeepCurrentChannel.enabled = true;
        LastFMRichPresence.enabled = true;
        MessageLatency.enabled = true;
        ReadAllNotificationsButton.enabled = true;
        YoutubeAdblock.enabled = true;
        VolumeBooster.enabled = true;
        Unindent.enabled = true;
        NotTypingAnimation.enabled = true;
        SilentTyping.enabled = true;
        SpotifyControls.enabled = true;
        OpenInApp.enabled = true;
        ReviewDB.enabled = true;
        NoDevtoolsWarning.enabled = true;
      };
    };
  };
}
