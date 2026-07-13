{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;

    defaultApplicationPackages = with pkgs; [
      neovim
      imv
      kdePackages.ark
      zathura
      libreoffice
      nautilus
      loupe
      # papers
      mpv
      firefox
    ];

    defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
    };

    /*
       defaultApplications = {
      "image/avif" = ["imv.desktop"];
      "image/bmp" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];
      "image/heic" = ["imv.desktop"];
      "image/heif" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
      "image/png" = ["imv.desktop"];
      "image/svg+xml" = ["imv.desktop"];
      "image/tiff" = ["imv.desktop"];
      "image/vnd.microsoft.icon" = ["imv.desktop"];
      "image/webp" = ["imv.desktop"];

      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "application/x-pdf" = ["org.pwmt.zathura.desktop"];
      "application/postscript" = ["org.pwmt.zathura.desktop"];
      "application/x-dvi" = ["org.pwmt.zathura.desktop"];
      "image/vnd.djvu" = ["org.pwmt.zathura.desktop"];
      "application/vnd.djvu" = ["org.pwmt.zathura.desktop"];

      "application/zip" = ["org.kde.ark.desktop"];
      "application/gzip" = ["org.kde.ark.desktop"];
      "application/x-7z-compressed" = ["org.kde.ark.desktop"];
      "application/x-bzip" = ["org.kde.ark.desktop"];
      "application/x-bzip2" = ["org.kde.ark.desktop"];
      "application/x-compressed-tar" = ["org.kde.ark.desktop"];
      "application/x-rar" = ["org.kde.ark.desktop"];
      "application/x-rar-compressed" = ["org.kde.ark.desktop"];
      "application/x-tar" = ["org.kde.ark.desktop"];
      "application/x-xz" = ["org.kde.ark.desktop"];
      "application/vnd.rar" = ["org.kde.ark.desktop"];

      "application/msword" = ["libreoffice-writer.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["libreoffice-writer.desktop"];
      "application/vnd.oasis.opendocument.text" = ["libreoffice-writer.desktop"];
      "application/rtf" = ["libreoffice-writer.desktop"];
      "text/rtf" = ["libreoffice-writer.desktop"];

      "application/vnd.ms-excel" = ["libreoffice-calc.desktop"];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["libreoffice-calc.desktop"];
      "application/vnd.oasis.opendocument.spreadsheet" = ["libreoffice-calc.desktop"];
      "text/csv" = ["libreoffice-calc.desktop"];

      "application/vnd.ms-powerpoint" = ["libreoffice-impress.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["libreoffice-impress.desktop"];
      "application/vnd.oasis.opendocument.presentation" = ["libreoffice-impress.desktop"];
       };
    */
  };
}
