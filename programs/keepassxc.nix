{...}: {
  programs.keepassxc = {
    enable = true;
    General = {
      BackupBeforeSave = true;
      BackupFilePathPattern = "/home/nyxar/Documents/KeePass/Backup/{DB_FILENAME}.old.kdbx";
      ConfigVersion = 2;
      DropToBackgroundOnCopy = true;
      HideWindowOnCopy = true;
      MinimizeOnCopy = false;
    };
    settings = {
      Browser.Enabled = true;

      GUI = {
        ApplicationTheme = "dark";
        ColorPasswords = true;
        HidePasswords = false;
        HideUsernames = false;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MinimizeToTray = true;
        ShowExpiredEntriesOnDatabaseUnlockOffsetDays = 1;
        ShowTrayIcon = true;
        TrayIconAppearance = "monochrome-dark";
      };

      PasswordGenerator = {
        AdditionalChars = "_-";
        AdvancedMode = true;
        Braces = false;
        Dashes = false;
        EASCII = false;
        Length = 19;
        Logograms = false;
        LowerCase = true;
        Math = false;
        Punctuation = false;
        Quotes = false;
        UpperCase = true;
      };

      Security = {
        IconDownloadFallback = true;
        LockDatabaseIdle = true;
      };
      SSHAgent.Enabled = true;
    };
  };
}
