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
    videospeed
    video-downloadhelper
    translate-web-pages
    facebook-container
    localcdn
    auto-tab-discard
  ];
  force = true;
  settings = let
    stgs = ./extensions-settings;
  in {
    "uBlock0@raymondhill.net".settings = import (stgs + /ublock.nix) {inherit lib;};
  };
}
