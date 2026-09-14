{
  programs = {
    zathura = {
      enable = true;
      options = {
        # Lecture
        adjust-open = "width";
        scroll-page-aware = true;
        scroll-wrap = false;
        scroll-step = 50;

        # Zoom
        zoom-step = 10;
        zoom-center = true;

        # Espacement entre les pages
        page-v-padding = 8;
        page-h-padding = 8;

        # Copier avec Ctrl+V normalement
        selection-clipboard = "clipboard";

        # Interface
        statusbar-home-tilde = true;
        statusbar-page-percent = true;
        window-title-basename = true;
        window-title-page = true;

        # Historique/bookmarks
        database = "sqlite";
      };
    };

  };
}
