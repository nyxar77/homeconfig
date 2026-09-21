{
  config,
  lib,
  pkgs,
  ...
}:
let
  isServer = config.nyx.role == "server";
in
{
  config.programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 20000;
    shortcut = "q";
    escapeTime = 10;
    resizeAmount = 15;
    customPaneNavigationAndResize = true;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #{=18:#{?automatic-rename,#{?#{==:#{pane_current_command},zsh},#{b:pane_current_path},#{pane_current_command}},#{window_name}}}"
          set -g @catppuccin_window_current_text " #{=18:#{?automatic-rename,#{?#{==:#{pane_current_command},zsh},#{b:pane_current_path},#{pane_current_command}},#{window_name}}}"
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          # set -g @resurrect-capture-pane-contents "on"
          set -g @resurrect-strategy-nvim "session"
          set -g @resurrect-strategy-vim "session"
          set -g @resurrect-delete-backup-after "10"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore "on"
          set -g @continuum-save-interval "15"

          set -g status-right-length 90
          set -g status-left-length 90
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_session}"
        '';
      }
    ];

    extraConfig = ''
      bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      set -g focus-events on
      set -g renumber-windows on
      set -s set-clipboard on
      set -g set-titles on

      bind r command-prompt "rename-window %%"
      bind p paste-buffer -p

      set -g mode-style 'bg=#634770'
      set -g copy-mode-match-style 'fg=#eee9fc,bg=#3f3951,bold'
      set -g copy-mode-current-match-style 'fg=#211e2a,bg=#e965a5,bold'
      set -g message-style 'fg=#eee9fc,bg=#3f3951'
      set -g pane-active-border-style 'fg=#e965a5,bg=default'
      set -g pane-border-style 'fg=#6e6780,bg=default'

      bind -T copy-mode-vi v send-keys -X begin-selection \; send-keys -X rectangle-on
    ''
    + lib.optionalString isServer ''
      set -as terminal-features ',xterm-256color:RGB,tmux-256color:RGB'
      set -as terminal-overrides ',xterm-256color:RGB,tmux-256color:RGB'

      bind S run-shell 'mkdir -p "$HOME/Pictures/tmux"; tmux capture-pane -pJS - > "$HOME/Pictures/tmux/tmux-$(date +%Y%m%d-%H%M%S).txt"; tmux display-message "Captured pane to ~/Pictures/tmux"'
      bind C run-shell 'mkdir -p "$HOME/.local/share/tmux"; tmux save-buffer "$HOME/.local/share/tmux/clipboard.txt"; tmux display-message "Saved buffer to ~/.local/share/tmux/clipboard.txt"'

      bind -T copy-mode-vi y set -g mode-style 'bg=#e192ef' \; refresh-client -S \; run-shell -d 0.12 \; set -g mode-style 'bg=#634770' \; send-keys -X copy-selection-and-cancel \; display-message 'Copied to tmux buffer'
      bind -T copy-mode-vi Y set -g mode-style 'bg=#e192ef' \; refresh-client -S \; run-shell -d 0.12 \; set -g mode-style 'bg=#634770' \; send-keys -X copy-selection-and-cancel \; display-message 'Copied to tmux buffer'
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel
    ''
    + lib.optionalString (!isServer) ''
      set -as terminal-features ',xterm-kitty:RGB:clipboard'
      set -as terminal-overrides ',xterm-kitty:RGB'

      bind -T copy-mode-vi y set -g mode-style 'bg=#e192ef' \; refresh-client -S \; run-shell -d 0.12 \; set -g mode-style 'bg=#634770' \; send-keys -X copy-selection-and-cancel \; run-shell -b 'tmux save-buffer - | ${pkgs.wl-clipboard}/bin/wl-copy' \; display-message 'Copied to clipboard and tmux buffer'
      bind -T copy-mode-vi Y set -g mode-style 'bg=#e192ef' \; refresh-client -S \; run-shell -d 0.12 \; set -g mode-style 'bg=#634770' \; send-keys -X copy-selection-and-cancel \; run-shell -b 'tmux save-buffer - | ${pkgs.wl-clipboard}/bin/wl-copy' \; display-message 'Copied to clipboard and tmux buffer'
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel \; run-shell -b 'tmux save-buffer - | ${pkgs.wl-clipboard}/bin/wl-copy'
    '';
  };
}
