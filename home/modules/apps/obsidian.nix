{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    defaultSettings = {
      app = {
        alwaysUpdateLinks = true;
        newFileLocation = "folder";
        newFileFolderPath = "00 Inbox";
        attachmentFolderPath = "99 Attachments";
        useMarkdownLinks = false;
        spellcheck = true;
        vimMode = true;
        showLineNumber = true;
        trashOption = "system";
        promptDelete = false;
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
        "templates"
        "daily-notes"
        "file-recovery"
        "workspaces"

        "bases"
        "command-palette"
        "editor-status"
        "note-composer"
        "word-count"
        "graph"
      ];

      communityPlugins = with pkgs.obsidianPlugins; [
        dataview
        table-editor-obsidian
        obsidian-importer
        vim-yank-highlight
        obsidian-git
        obsidian-spaced-repetition
        templater-obsidian
        omnisearch
        obsidian-tasks-plugin
        obsidian-style-settings
      ];

      themes = with pkgs.obsidianThemes; [
        catppuccin
      ];
    };

    vaults = {
      notes = {
        target = "Documents/Notes";
      };
    };
  };
}
