{
  uiLanguage = "default";
  pageTranslatorService = "google";
  textTranslatorService = "google";
  textToSpeechService = "google";
  enabledServices = [
    "google"
    "bing"
    "deepl"
  ];

  ttsSpeed = "1";
  ttsVolume = "1";

  targetLanguage = "fr";
  targetLanguageTextTranslation = "en";
  targetLanguages = [
    "fr"
    "en"
    "ar"
  ];

  alwaysTranslateSites = [];
  neverTranslateSites = ["github.com"];
  sitesToTranslateWhenHovering = [];
  langsToTranslateWhenHovering = [];
  alwaysTranslateLangs = ["en"];
  neverTranslateLangs = [];
  customDictionary = {};

  showTranslatePageContextMenu = "yes";
  showTranslateSelectedContextMenu = "yes";
  showButtonInTheAddressBar = "yes";
  showOriginalTextWhenHovering = "no";
  showTranslateSelectedButton = "yes";
  whenShowMobilePopup = "when-necessary";
  useOldPopup = "no";
  darkMode = "yes";
  popupBlueWhenSiteIsTranslated = "yes";
  popupPanelSection = 1;
  showReleaseNotes = "yes";

  dontShowIfIsNotValidText = "yes";
  dontShowIfPageLangIsTargetLang = "no";
  dontShowIfPageLangIsUnknown = "no";
  dontShowIfSelectedTextIsTargetLang = "no";
  dontShowIfSelectedTextIsUnknown = "no";

  hotkeys = {
    "hotkey-toggle-translation" = "Ctrl+Alt+T";
    "hotkey-translate-selected-text" = "Ctrl+Alt+S";
    "hotkey-swap-page-translation-service" = "Ctrl+Alt+Q";
    "hotkey-show-original" = "Shift+Alt+0";
    "hotkey-translate-page-1" = "Shift+Alt+1";
    "hotkey-translate-page-2" = "Shift+Alt+2";
    "hotkey-translate-page-3" = "Shift+Alt+3";
    "hotkey-hot-translate-selected-text" = "Ctrl+Alt+X";
  };

  expandPanelTranslateSelectedText = "yes";
  translateTag_pre = "yes";
  enableIframePageTranslation = "yes";
  dontSortResults = "no";
  translateDynamicallyCreatedContent = "yes";
  autoTranslateWhenClickingALink = "no";
  translateSelectedWhenPressTwice = "no";
  translateTextOverMouseWhenPressTwice = "no";
  translateClickingOnce = "no";
  enableDiskCache = "yes";
  useAlternativeService = "yes";
  customServices = [];

  showMobilePopupOnDesktop = "no";
  popupMobileKeepOnScren = "no";
  popupMobilePosition = "top";
  addPaddingToPage = "no";
  proxyServers = {};
}
