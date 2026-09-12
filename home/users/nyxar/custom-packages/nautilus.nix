{ lib, ... }:
{
  dconf.settings = {
    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "medium";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = lib.hm.gvariant.mkTuple [ 890 550 ];
      maximized = true;
    };
  };
}
