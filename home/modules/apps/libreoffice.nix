{
  config,
  lib,
  pkgs,
  ...
}:
let
  generatedThemeDir = "${config.xdg.stateHome}/caelestia/theme";
  libreofficeCaelestia = pkgs.symlinkJoin {
    name = "libreoffice-caelestia";
    paths = [ pkgs.libreoffice ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for executable in libreoffice soffice sbase scalc sdraw simpress smath swriter; do
        wrapProgram "$out/bin/$executable" \
          --set GTK_THEME Caelestia-LibreOffice \
          --set SAL_USE_VCLPLUGIN gtk3
      done
    '';
  };
in
{
  home.packages = [ libreofficeCaelestia ];

  xdg.configFile."caelestia/templates/libreoffice.css".text = ''
    /*
      Keep LibreOffice's stock Adwaita GTK geometry and replace colours only.
      The generated mode switches the Adwaita base between light and dark.
    */
    @import url("base-{{ mode }}.css");

    @define-color theme_fg_color #{{ onSurface.hex }};
    @define-color theme_text_color #{{ onSurface.hex }};
    @define-color theme_bg_color #{{ surface.hex }};
    @define-color theme_base_color #{{ surfaceContainerLowest.hex }};
    @define-color theme_unfocused_fg_color #{{ onSurfaceVariant.hex }};
    @define-color theme_unfocused_text_color #{{ onSurfaceVariant.hex }};
    @define-color theme_unfocused_bg_color #{{ surfaceContainerLow.hex }};
    @define-color theme_unfocused_base_color #{{ surfaceContainerLowest.hex }};
    @define-color theme_selected_bg_color #{{ primary.hex }};
    @define-color theme_selected_fg_color #{{ onPrimary.hex }};
    @define-color insensitive_bg_color #{{ surfaceContainer.hex }};
    @define-color insensitive_fg_color #{{ onSurfaceVariant.hex }};
    @define-color borders #{{ outlineVariant.hex }};
    @define-color unfocused_borders #{{ surfaceContainerHighest.hex }};
    @define-color warning_color #{{ tertiary.hex }};
    @define-color error_color #{{ error.hex }};
    @define-color success_color #{{ primary.hex }};
    @define-color link_color #{{ primary.hex }};
    @define-color visited_link_color #{{ secondary.hex }};

    window,
    dialog,
    .background {
      color: @theme_fg_color;
      background-color: @theme_bg_color;
    }

    headerbar,
    .titlebar,
    menubar,
    toolbar,
    .toolbar {
      color: @theme_fg_color;
      background-color: #{{ surfaceContainerLow.hex }};
      background-image: linear-gradient(
        to bottom,
        #{{ surfaceContainer.hex }},
        #{{ surfaceContainerLow.hex }}
      );
      border-color: @borders;
    }

    button,
    combobox button,
    spinbutton,
    entry {
      color: @theme_fg_color;
      background-color: #{{ surfaceContainerHigh.hex }};
      background-image: linear-gradient(
        to bottom,
        #{{ surfaceContainerHighest.hex }},
        #{{ surfaceContainerHigh.hex }}
      );
      border-color: @borders;
    }

    button:hover,
    combobox button:hover {
      color: #{{ onPrimaryContainer.hex }};
      background-color: #{{ primaryContainer.hex }};
      background-image: linear-gradient(
        to bottom,
        #{{ primaryContainer.hex }},
        #{{ surfaceContainerHighest.hex }}
      );
      border-color: #{{ primary.hex }};
    }

    button:active,
    button:checked,
    combobox button:active,
    combobox button:checked {
      color: #{{ onPrimary.hex }};
      background-color: #{{ primary.hex }};
      background-image: none;
      border-color: #{{ primary.hex }};
    }

    entry,
    textview text,
    treeview.view,
    iconview.view,
    .view {
      color: @theme_text_color;
      background-color: @theme_base_color;
    }

    selection,
    treeview.view:selected,
    iconview.view:selected,
    .view:selected {
      color: @theme_selected_fg_color;
      background-color: @theme_selected_bg_color;
    }

    menu,
    menuitem,
    popover {
      color: @theme_fg_color;
      background-color: #{{ surfaceContainer.hex }};
    }

    menuitem:hover,
    menuitem:selected,
    popover modelbutton:hover {
      color: #{{ onPrimaryContainer.hex }};
      background-color: #{{ primaryContainer.hex }};
    }

    notebook > header,
    notebook > header > tabs > tab {
      color: @theme_unfocused_fg_color;
      background-color: #{{ surfaceContainerLow.hex }};
      border-color: @borders;
    }

    notebook > header > tabs > tab:checked {
      color: #{{ primary.hex }};
      background-color: #{{ surfaceContainerHigh.hex }};
      border-color: #{{ primary.hex }};
    }

    scrollbar slider {
      background-color: #{{ outline.hex }};
    }

    scrollbar slider:hover {
      background-color: #{{ primary.hex }};
    }

    tooltip {
      color: #{{ inverseOnSurface.hex }};
      background-color: #{{ inverseSurface.hex }};
      border-color: @borders;
    }

    *:disabled {
      color: @insensitive_fg_color;
      border-color: @unfocused_borders;
    }
  '';

  xdg.dataFile."themes/Caelestia-LibreOffice/gtk-3.0/gtk.css".source =
    config.lib.file.mkOutOfStoreSymlink "${generatedThemeDir}/libreoffice.css";

  xdg.dataFile."themes/Caelestia-LibreOffice/gtk-3.0/base-dark.css".text = ''
    @import url("resource:///org/gtk/libgtk/theme/Adwaita/gtk-contained-dark.css");
  '';

  xdg.dataFile."themes/Caelestia-LibreOffice/gtk-3.0/base-light.css".text = ''
    @import url("resource:///org/gtk/libgtk/theme/Adwaita/gtk-contained.css");
  '';

  # LibreOffice keeps all user preferences in one generated XML file. Only
  # update its two appearance selectors; leave documents, history, toolbars,
  # and the rest of the profile under LibreOffice's control.
  home.activation.libreofficeAutomaticAppearance = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    registry="${config.xdg.configHome}/libreoffice/4/user/registrymodifications.xcu"

    if [ -f "$registry" ]; then
      $DRY_RUN_CMD ${pkgs.perl}/bin/perl -0pi -e '
        s{(<item oor:path="/org\.openoffice\.Office\.Common/Appearance"><prop oor:name="ApplicationAppearance"[^>]*><value>)[^<]*(</value></prop></item>)}{$1 . "0" . $2}ge;
        s{(<item oor:path="/org\.openoffice\.Office\.Common/Appearance"><prop oor:name="LibreOfficeTheme"[^>]*><value>)[^<]*(</value></prop></item>)}{$1 . "0" . $2}ge;
      ' "$registry"
    fi
  '';
}
