{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

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

        # addition
        autoConvertHtml = true;
        showIndentGuide = true;
        showInlineTitle = true;
        readableLineLength = false;
        newLinkFormat = "shortest";
        /*
        propertiesInDocument = "visible";
        */
      };

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
        "graph"
        {
          name = "daily-notes";
          settings = {
            folder = "Daily";
            format = "YYYY-MM-DD";
          };
        }
        {
          name = "templates";
        }
      ];

      communityPlugins = with pkgs.obsidianPlugins; [
        obsidian-git
        omnisearch
        vim-yank-highlight
        background-tray

        # Add these when you actually need them:
        # obsidian-tasks-plugin
        # table-editor-obsidian
        # templater-obsidian
        # dataview
        # obsidian-style-settings
      ];

      themes = with pkgs.obsidianThemes; [
        catppuccin
      ];
    };

    vaults = {
      notes = {
        target = "Documents/Knowledge";
      };
    };
  };
}
