{
  enableNotifications = false;

  redirects = [
    {
      description = "Instagram -> Imginn";
      exampleUrl = "https://www.instagram.com/username/";
      exampleResult = "https://imginn.com/username/";
      error = null;
      includePattern = "https://www.instagram.com/*";
      excludePattern = "";
      patternDesc = "Pattern applies to: Main window";
      redirectUrl = "https://imginn.com/$1";
      patternType = "W";
      processMatches = "noProcessing";
      disabled = false;
      grouped = false;
      appliesTo = [
        "main_frame"
      ];
    }
  ];
}
