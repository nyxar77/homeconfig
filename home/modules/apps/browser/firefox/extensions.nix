{
  lib,
  pkgs,
}: {
  packages = with pkgs.nur.repos.rycee.firefox-addons; [
    stylus
    firefox-color
    ublock-origin
    privacy-badger
    darkreader
    keepassxc-browser
    chameleon-ext
    ff2mpv
    buster-captcha-solver
    canvasblocker
    sponsorblock
    clearurls
    nicothin-space
    search-by-image
    return-youtube-dislikes
    video-downloadhelper
    translate-web-pages
    facebook-container
    localcdn
    auto-tab-discard
    catppuccin-web-file-icons
    redirector
    #hoverTranslate
  ];
  force = true;
  settings = let
    stgs = ./extensions-settings;
  in {
    "uBlock0@raymondhill.net".settings = import (stgs + /ublock.nix) {inherit lib;};
    "addon@darkreader.org".settings = import (stgs + /darkreader.nix);
    "CanvasBlocker@kkapsner.de".settings = import (stgs + /canvasblocker.nix);
    "sponsorBlocker@ajay.app".settings = import (stgs + /sponsorblock.nix);
    "redirector@einaregilsson.com".settings = import (stgs + /redirector.nix);
    "{74145f27-f039-47ce-a470-a662b129930a}".settings = import (stgs + /clearurls.nix);
    "{b86e4813-687a-43e6-ab65-0bde4ab75758}".settings = import (stgs + /localcdn.nix);
    "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".settings = import (stgs + /auto-tab-discard.nix);
    "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}".settings = import (stgs + /translate-web-pages.nix);
    # "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}".settings = import (stgs + /chameleon.nix);
  };
}
