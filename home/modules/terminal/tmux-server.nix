{pkgs, ...}: {
  programs.tmux = {
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
      catppuccin
      resurrect
      continuum
    ];

    extraConfig = ''
      bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      bind S run-shell 'mkdir -p "$HOME/Pictures/tmux"; tmux capture-pane -pJS - > "$HOME/Pictures/tmux/tmux-$(date +%Y%m%d-%H%M%S).txt"; tmux display-message "Captured pane to ~/Pictures/tmux"'
      bind C run-shell 'mkdir -p "$HOME/.local/share/tmux"; tmux save-buffer "$HOME/.local/share/tmux/clipboard.txt"; tmux display-message "Saved buffer to ~/.local/share/tmux/clipboard.txt"'

      set -g mouse on
      set -g focus-events on
      set -g renumber-windows on
      set -g set-clipboard on
      set -g set-titles on
      set -g default-shell ${pkgs.zsh}/bin/zsh
      set -g default-command ${pkgs.zsh}/bin/zsh

      set -as terminal-features ',xterm-256color:RGB,tmux-256color:RGB'
      set -as terminal-overrides ',xterm-256color:RGB,tmux-256color:RGB'

      bind r command-prompt "rename-window %%"
      bind p paste-buffer

      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"
      set -g status-right-length 90
      set -g status-left-length 90
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"

      set -g mode-style 'fg=#211e2a,bg=#ebde76,bold'
      set -g copy-mode-match-style 'fg=#211e2a,bg=#b1baf4,bold'
      set -g copy-mode-current-match-style 'fg=#211e2a,bg=#e965a5,bold'
      set -g message-style 'fg=#eee9fc,bg=#3f3951'
      set -g pane-active-border-style 'fg=#e965a5,bg=default'
      set -g pane-border-style 'fg=#6e6780,bg=default'

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi Y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel

      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-strategy-vim 'session'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
    '';
  };
}
