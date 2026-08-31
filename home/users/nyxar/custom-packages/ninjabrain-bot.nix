{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  xml = pkgs.formats.xml { };
  bool = value: if value then "true" else "false";

  boundedFloat = default: min: max: description:
    mkOption {
      type = types.addCheck types.float (value: value >= min && value <= max);
      inherit default description;
    };

  hotkeyType = types.nullOr (types.submodule {
    options = {
      modifier = mkOption {
        type = types.int;
        description = "JNativeHook modifier mask.";
      };
      keyCode = mkOption {
        type = types.int;
        description = "Platform-specific JNativeHook key code.";
      };
    };
  });

  hotkeyOption = description:
    mkOption {
      type = hotkeyType;
      default = null;
      inherit description;
    };
in
{
  meta.maintainers = [ lib.maintainers.nyxar77 ];

  options.programs.ninjabrain-bot = {
    enable = mkEnableOption "Ninjabrain Bot";

    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "The Ninjabrain Bot package to install.";
    };

    settings = mkOption {
      type = types.submodule {
        options = {
          theme = mkOption {
            type = types.int;
            default = 1;
            description = "Theme index used by Ninjabrain Bot.";
          };
          language = mkOption {
            type = types.enum [
              "en-US"
              "es-ES"
              "it-IT"
              "ja-JP"
              "ja-x-lvariant-Ryukyuan"
              "ko-KR"
              "pl-PL"
              "pt-PT"
              "pt-BR"
              "ru-RU"
              "zh-CN"
              "zh-TW"
              "fr-FR"
              "uk-UA"
              "cs-CZ"
              "tr-TR"
            ];
            default = "en-US";
            description = "Interface language. Takes effect after restarting Ninjabrain Bot.";
          };
          windowSize = mkOption {
            type = types.enum [ "small" "medium" "large" ];
            default = "small";
            description = "Main window size.";
          };
          strongholdDisplay = mkOption {
            type = types.enum [ "four-four" "eight-eight" "chunk" ];
            default = "four-four";
            description = "Format used to display the stronghold location.";
          };
          view = mkOption {
            type = types.enum [ "basic" "detailed" ];
            default = "basic";
            description = "Main calculator view.";
          };
          minecraftVersion = mkOption {
            type = types.enum [ "1.9-1.18" "1.19+" ];
            default = "1.9-1.18";
            description = "Minecraft version used for calculations.";
          };

          checkForUpdates = mkOption { type = types.bool; default = true; };
          translucentWindow = mkOption { type = types.bool; default = false; };
          alwaysOnTop = mkOption { type = types.bool; default = true; };
          showNetherCoordinates = mkOption { type = types.bool; default = true; };
          showAngleUpdates = mkOption { type = types.bool; default = false; };
          showAngleErrors = mkOption { type = types.bool; default = false; };
          autoReset = mkOption { type = types.bool; default = false; };
          autoResetOnInstanceChange = mkOption { type = types.bool; default = false; };
          useAdvancedStrongholdStatistics = mkOption { type = types.bool; default = true; };
          useAlternativeClipboardReader = mkOption { type = types.bool; default = false; };
          useAlternativeStandardDeviation = mkOption { type = types.bool; default = false; };
          colorNegativeCoordinates = mkOption { type = types.bool; default = false; };
          usePreciseAngle = mkOption { type = types.bool; default = false; };
          useObsOverlay = mkOption { type = types.bool; default = false; };
          saveState = mkOption { type = types.bool; default = true; };
          enableHttpServer = mkOption { type = types.bool; default = false; };
          overlayAutoHide = mkOption { type = types.bool; default = false; };
          overlayHideWhenLocked = mkOption { type = types.bool; default = false; };
          allAdvancements = mkOption { type = types.bool; default = false; };
          oneDotTwentyPlusAllAdvancements = mkOption { type = types.bool; default = false; };
          mismeasureWarning = mkOption { type = types.bool; default = false; };
          directionHelp = mkOption { type = types.bool; default = false; };
          combinedCertaintyInformation = mkOption { type = types.bool; default = true; };
          portalLinkingWarning = mkOption { type = types.bool; default = true; };

          sensitivityManual = boundedFloat 0.4341732 0.0 1.0 "Sensitivity for Minecraft 1.9-1.12.";
          sigma = boundedFloat 0.1 0.001 1.0 "Standard deviation for Minecraft 1.13+.";
          sigmaAlt = boundedFloat 0.1 0.001 1.0 "Alternative standard deviation for the last angle.";
          sigmaManual = boundedFloat 0.03 0.001 1.0 "Standard deviation for Minecraft 1.9-1.12.";
          sigmaBoat = boundedFloat 0.001 0.0001 1.0 "Standard deviation for boat throws.";
          resolutionHeight = boundedFloat 16384.0 1.0 16384.0 "Resolution height for tall-resolution angle adjustment.";
          boatError = boundedFloat 0.03 0.0 0.7 "Allowed boat-angle error.";
          overlayHideDelay = boundedFloat 30.0 1.0 3600.0 "Seconds before an idle OBS overlay is hidden.";
          sensitivityAutomatic = boundedFloat 0.012727597 0.0 1.0 "Sensitivity for Minecraft 1.13+.";
          customAdjustment = boundedFloat 0.01 0.0 1.0 "Amount used with custom angle adjustment.";
          crosshairCorrection = boundedFloat 0.0 (-1.0) 1.0 "Crosshair correction.";

          defaultBoatType = mkOption {
            type = types.enum [ "gray" "blue" "green" ];
            default = "gray";
          };
          allAdvancementsToggle = mkOption {
            type = types.enum [ "automatic" "hotkey" ];
            default = "automatic";
          };
          angleAdjustmentType = mkOption {
            type = types.enum [ "subpixel" "tall-resolution" "custom" ];
            default = "subpixel";
          };
          angleAdjustmentDisplay = mkOption {
            type = types.enum [ "angle-change" "increments" ];
            default = "angle-change";
          };

          hotkeys = {
            increment = hotkeyOption "Increase the last angle by 0.01.";
            decrement = hotkeyOption "Decrease the last angle by 0.01.";
            boat = hotkeyOption "Mark the next F3+C as a boat-angle reset.";
            mod360 = hotkeyOption "Mark the next F3+C as an angle reduction modulo 360.";
            reset = hotkeyOption "Reset the calculator.";
            undo = hotkeyOption "Undo the previous throw.";
            redo = hotkeyOption "Redo the next throw.";
            minimize = hotkeyOption "Toggle calculator visibility.";
            alternativeStandardDeviation = hotkeyOption "Toggle alternative standard deviation for the last angle.";
            lock = hotkeyOption "Lock the calculator.";
            toggleAllAdvancements = hotkeyOption "Toggle all-advancements mode.";
          };
        };
      };
      default = { };
      description = "Ninjabrain Bot preferences. These replace the app-managed Java preference file.";
    };
  };

  config =
    let
      cfg = config.programs.ninjabrain-bot;
      s = cfg.settings;
      enum = values: value: toString values.${value};
      hotkeyEntries = key: hotkey:
        if hotkey == null then
          {
            "${key}_modifier" = "-1";
            "${key}_code" = "-1";
          }
        else
          {
            "${key}_modifier" = toString hotkey.modifier;
            "${key}_code" = toString hotkey.keyCode;
          };
      preferences =
        {
          theme = toString s.theme;
          language_v2 = s.language;
          size = enum { small = 0; medium = 1; large = 2; } s.windowSize;
          stronghold_display_type = enum { "four-four" = 0; "eight-eight" = 1; chunk = 2; } s.strongholdDisplay;
          view = enum { basic = 0; detailed = 1; } s.view;
          mc_version = enum { "1.9-1.18" = 0; "1.19+" = 1; } s.minecraftVersion;
          check_for_updates = bool s.checkForUpdates;
          translucent = bool s.translucentWindow;
          always_on_top = bool s.alwaysOnTop;
          show_nether_coords = bool s.showNetherCoordinates;
          show_angle_updates = bool s.showAngleUpdates;
          show_angle_errors = bool s.showAngleErrors;
          auto_reset = bool s.autoReset;
          auto_reset_on_instance_change = bool s.autoResetOnInstanceChange;
          use_adv_statistics = bool s.useAdvancedStrongholdStatistics;
          alt_clipboard_reader = bool s.useAlternativeClipboardReader;
          use_alt_std = bool s.useAlternativeStandardDeviation;
          color_negative_coords = bool s.colorNegativeCoordinates;
          use_precise_angle = bool s.usePreciseAngle;
          use_obs_overlay = bool s.useObsOverlay;
          save_state = bool s.saveState;
          enable_http_server = bool s.enableHttpServer;
          overlay_auto_hide = bool s.overlayAutoHide;
          overlay_lock_hide = bool s.overlayHideWhenLocked;
          all_advancements = bool s.allAdvancements;
          one_dot_twenty_plus_aa = bool s.oneDotTwentyPlusAllAdvancements;
          mismeasure_warning_enabled = bool s.mismeasureWarning;
          direction_help_enabled = bool s.directionHelp;
          combined_offset_information_enabled = bool s.combinedCertaintyInformation;
          portal_linking_warning_enabled = bool s.portalLinkingWarning;
          sensitivity_manual = toString s.sensitivityManual;
          sigma = toString s.sigma;
          sigma_alt = toString s.sigmaAlt;
          sigma_manual = toString s.sigmaManual;
          sigma_boat = toString s.sigmaBoat;
          resolution_height = toString s.resolutionHeight;
          boat_error = toString s.boatError;
          overlay_hide_delay = toString s.overlayHideDelay;
          sensitivity = toString s.sensitivityAutomatic;
          custom_adjustment = toString s.customAdjustment;
          crosshair_correction = toString s.crosshairCorrection;
          default_boat_type = enum { gray = 0; blue = 1; green = 2; } s.defaultBoatType;
          aa_toggle_type = enum { automatic = 0; hotkey = 1; } s.allAdvancementsToggle;
          angle_adjustment_type = enum { subpixel = 0; "tall-resolution" = 1; custom = 2; } s.angleAdjustmentType;
          angle_adjustment_display_type = enum { "angle-change" = 0; increments = 1; } s.angleAdjustmentDisplay;
          settings_version = "3";
        }
        // hotkeyEntries "hotkey_increment" s.hotkeys.increment
        // hotkeyEntries "hotkey_decrement" s.hotkeys.decrement
        // hotkeyEntries "hotkey_boat" s.hotkeys.boat
        // hotkeyEntries "hotkey_mod_360" s.hotkeys.mod360
        // hotkeyEntries "hotkey_reset" s.hotkeys.reset
        // hotkeyEntries "hotkey_undo" s.hotkeys.undo
        // hotkeyEntries "hotkey_redo" s.hotkeys.redo
        // hotkeyEntries "hotkey_minimize" s.hotkeys.minimize
        // hotkeyEntries "hotkey_alt_std" s.hotkeys.alternativeStandardDeviation
        // hotkeyEntries "hotkey_lock" s.hotkeys.lock
        // hotkeyEntries "hotkey_toggle_aa_mode" s.hotkeys.toggleAllAdvancements;
      preferencesXml = xml.generate "ninjabrain-bot-prefs.xml" {
        map = {
          "@MAP_XML_VERSION" = "1.0";
          entry = lib.mapAttrsToList (key: value: {
            "@key" = key;
            "@value" = value;
          }) preferences;
        };
      };
      javaPreferencesXml = pkgs.runCommand "ninjabrain-bot-prefs.xml" { } ''
        {
          head -n 1 ${preferencesXml}
          printf '%s\n' '<!DOCTYPE map SYSTEM "http://java.sun.com/dtd/preferences.dtd">'
          tail -n +2 ${preferencesXml}
        } > "$out"
      '';
    in
    mkIf cfg.enable {
      assertions = [
        {
          assertion = !s.overlayAutoHide || s.useObsOverlay;
          message = "programs.ninjabrain-bot.settings.overlayAutoHide requires useObsOverlay = true.";
        }
        {
          assertion = !s.overlayHideWhenLocked || s.useObsOverlay;
          message = "programs.ninjabrain-bot.settings.overlayHideWhenLocked requires useObsOverlay = true.";
        }
        {
          assertion = !s.oneDotTwentyPlusAllAdvancements || s.allAdvancements;
          message = "programs.ninjabrain-bot.settings.oneDotTwentyPlusAllAdvancements requires allAdvancements = true.";
        }
        {
          assertion = !s.allAdvancements || !s.autoReset;
          message = "Ninjabrain Bot disables autoReset while allAdvancements is enabled.";
        }
        {
          assertion = s.useAlternativeStandardDeviation || s.hotkeys.alternativeStandardDeviation == null;
          message = "programs.ninjabrain-bot.settings.hotkeys.alternativeStandardDeviation requires useAlternativeStandardDeviation = true.";
        }
        {
          assertion = s.usePreciseAngle || (s.hotkeys.boat == null && s.hotkeys.mod360 == null);
          message = "Boat hotkeys require usePreciseAngle = true.";
        }
        {
          assertion = !s.allAdvancements || s.allAdvancementsToggle == "hotkey" || s.hotkeys.toggleAllAdvancements == null;
          message = "hotkeys.toggleAllAdvancements requires allAdvancementsToggle = \"hotkey\".";
        }
      ];

      home.packages = lib.optional (cfg.package != null) cfg.package;

      home.file.".java/.userPrefs/ninjabrainbot/prefs.xml" = {
        force = true;
        source = javaPreferencesXml;
      };
    };
}
