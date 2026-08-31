{ pkgs, ... }:
let
  path = "Documents/Notes";
in
{
  home.file."${path}/.obsidian.vimrc".text = ''
    set clipboard=unnamedplus
  '';
  programs.obsidian = {
    enable = true;

    vaults = {
      notes = {
        target = path;
      };
    };
    defaultSettings = {
      app = {
        alwaysUpdateLinks = true;
        useMarkdownLinks = false;
        newFileLocation = "folder";
        newFileFolderPath = "00 Inbox";
        attachmentFolderPath = "99 Attachments";
        spellcheck = true;
        vimMode = true;
        showLineNumber = true;
        trashOption = "system";
        promptDelete = false;
        showUnsupportedFiles = true;
        defaultViewMode = "preview";
        livePreview = false;

        # addition
        autoConvertHtml = true;
        showIndentGuide = true;
        showInlineTitle = true;
        readableLineLength = false;
        newLinkFormat = "shortest";
        # propertiesInDocument = "visible";

        /*
          userIgnoreFilters = [
            "Images & Attachments/"
            "Templates/"
            "sortspec"
          ];
        */

      };

      /*
           extraFiles = {
          ".obsidian.vimrc".text = ''
            set clipboard=unnamedplus
          '';
        };
      */

      appearance = {
        theme = "system";
        accentColor = "#ff5789";
        baseFontSizeAction = false;
        baseFontSize = 18;
      };

      corePlugins = [
        "file-explorer"
        "global-search"
        "switcher"
        "backlink"
        "outgoing-link"
        "bookmarks"
        "outline"
        "page-preview"
        "properties"
        "tag-pane"
        "file-recovery"
        "workspaces"

        "bases"
        "command-palette"
        "editor-status"
        "note-composer"
        "word-count"

        {
          name = "daily-notes";
          settings = {
            folder = "Daily";
            format = "YYYY-MM-DD";
            template = "Templates/Daily";
          };
        }

        /*
             {
            name = "templates";
          }
        */
        {
          name = "graph";
          settings = {
            search = ''-path:"Templates" -file:"sortspec" -file:"Tasks" -file:"Activity" -file:"Inbox"'';

            showTags = true;
            showAttachments = false;
            hideUnresolved = false;
            showOrphans = true;
          };
        }
      ];

      communityPlugins = with pkgs.obsidianPlugins; [
        obsidian-git
        omnisearch
        vim-yank-highlight
        background-tray
        various-complements
        file-explorer-note-count
        calendar
        # cmdr # commander
        obsidian-tasks-plugin
        obsidian-vimrc-support
        custom-sort
        heatmap-tracker
        templater-obsidian
        hide-folders
        metadata-menu

        # Add these when you actually need them:
        # obsidian-tasks-plugin
        # table-editor-obsidian
        # templater-obsidian
        dataview
        # obsidian-style-settings
      ];

      themes = with pkgs.obsidianThemes; [
        # catppuccin
        # obsidianite
        maple
      ];
    };
  };
}
