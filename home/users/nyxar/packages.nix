{ pkgs, ... }:
let
  braveNoBackground = pkgs.symlinkJoin {
    name = "brave-no-background";
    paths = [ pkgs.brave ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/brave" --add-flags "--disable-background-mode"
    '';
  };
in
{
  home.packages = with pkgs; [
    braveNoBackground
    kdePackages.ark
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-us
    arrpc
    qbittorrent
    discover-overlay
    metadata-cleaner
    ff2mpv
    rnote
    /*
         (unstablePkgs.stremio-linux-shell.overrideAttrs (
        finalAttrs: previousAttrs: {
          version = "1.2.0";

          src = unstablePkgs.fetchFromGitHub {
            inherit (previousAttrs.src) owner repo;
            tag = "v${finalAttrs.version}";
            hash = "sha256-JFG+sUuK+l8Ik00vHPiXJwan0rmMBiY85DnvudYKCsw=";
          };

          cargoDeps = unstablePkgs.rustPlatform.fetchCargoVendor {
            inherit (finalAttrs) pname version src;
            hash = "sha256-FnQ2FN9NtL/YyRmLlyGQApjzV/4uS8OnnY8kbTWTGe8=";
          };
        }
      ))
    */
  ];
}
