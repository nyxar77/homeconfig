{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.gwenview;

  listToValue = lib.concatMapStringsSep "," (lib.generators.mkValueStringDefault { });
  iniFormat = pkgs.formats.ini { inherit listToValue; };
in
{
  meta.maintainers = [ lib.maintainers.nyxar77 ];

  options.programs.gwenview = {
    enable = lib.mkEnableOption "Gwenview";

    package = lib.mkPackageOption pkgs [ "kdePackages" "gwenview" ] { nullable = true; };

    settings = lib.mkOption {
      inherit (iniFormat) type;
      default = { };
      example = {
        General = {
          HistoryEnabled = true;
          JPEGQuality = 90;
          PercentageOfMemoryUsageWarning = 0.5;
        };
        ImageView = {
          EnlargeSmallerImages = false;
          ThumbnailSplitterSizes = [
            350
            100
          ];
        };
        "slide show" = {
          interval = 5.0;
          loop = false;
        };
      };
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/gwenviewrc`.

        Gwenview's supported settings and their types are defined in
        <https://invent.kde.org/graphics/gwenview/-/blob/master/lib/gwenviewconfig.kcfg>.
        Boolean, integer, floating-point, string, and non-empty list values are
        supported. Lists are encoded as comma-separated KConfig values.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile."gwenviewrc" = lib.mkIf (cfg.settings != { }) {
      source = iniFormat.generate "gwenviewrc" cfg.settings;
    };
  };
}
