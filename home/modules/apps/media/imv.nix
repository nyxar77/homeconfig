{
  config,
  lib,
  pkgs,
  ...
}:
let
  caelestia = lib.getExe config.programs.caelestia.cli.package;
  imvLauncher = pkgs.writeShellScriptBin "imv" ''
    stdin_file=""
    args=()

    for arg in "$@"; do
      if [[ "$arg" == "-" ]]; then
        if [[ -z "$stdin_file" ]]; then
          stdin_file="$(${pkgs.coreutils}/bin/mktemp /tmp/imv-stdin.XXXXXX)"
          ${pkgs.coreutils}/bin/cat > "$stdin_file"
        fi
        args+=("$stdin_file")
      else
        args+=("$arg")
      fi
    done

    exec ${lib.getExe pkgs.imv} "''${args[@]}"
  '';
  imvPackage = pkgs.symlinkJoin {
    name = "imv-with-stdin-cache";
    paths = [
      imvLauncher
      pkgs.imv
    ];
  };
  themeSettings = {
    options = {
      background = "{{ surface.hex }}";
      overlay_text_color = "{{ onSurface.hex }}";
      overlay_background_color = "{{ surfaceContainerLowest.hex }}";
    };
  };

  userSettings = {
    aliases.e = ''exec ${lib.getExe pkgs.uwsm} app -t service -- ${lib.getExe' pkgs.kdePackages.gwenview "gwenview"} "$imv_current_file"'';
  };

  settings = lib.recursiveUpdate themeSettings userSettings;
  template = pkgs.writeText "caelestia-imv.conf" (lib.generators.toINI { } settings);
in
{
  programs.imv = {
    enable = true;
    package = imvPackage;
  };

  xdg.configFile."caelestia/templates/imv.conf" = {
    source = lib.mkForce template;
    onChange = ''
      name="$(${caelestia} scheme get --name)"
      flavour="$(${caelestia} scheme get --flavour)"
      mode="$(${caelestia} scheme get --mode)"
      variant="$(${caelestia} scheme get --variant)"

      ${caelestia} scheme set \
        --name "$name" \
        --flavour "$flavour" \
        --mode "$mode" \
        --variant "$variant"
    '';
  };
}
