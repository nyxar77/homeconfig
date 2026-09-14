{ pkgs, ... }:
let
  keepassxcXcb = pkgs.symlinkJoin {
    name = "keepassxc-xcb";
    paths = [ pkgs.keepassxc ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/keepassxc \
        --set QT_QPA_PLATFORM xcb
    '';
  };
in
{
  programs.keepassxc = {
    enable = true;
    package = keepassxcXcb;
    settings = {
      Browser.Enabled = true;
      General = {
        BackupBeforeSave = true;
        BackupFilePathPattern = "{DB_FILENAME}.old.kdbx";
        CompactMode = true;
        ConfigVersion = 2;
        DropToBackgroundOnCopy = true;
        HideWindowOnCopy = true;
        MinimizeOnCopy = false;
      };

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
        TrayIconAppearance = "colorful";

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
