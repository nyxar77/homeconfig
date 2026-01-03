{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 20000;
    shortcut = "q";
    escapeTime = 0;
    resizeAmount = 15;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    plugins = with pkgs; [
      # tmuxPlugins.better-mouse-mode
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      # Reload tmux config
      bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      set -g renumber-windows on

      # Rename window
      bind r command-prompt "rename-window %%"
      set -s set-clipboard on

      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"
      set -g status-right-length 90
      set -g status-left-length 90
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      # set -ag status-right "#{E:@catppuccin_status_uptime}"
      # set -agF status-right "#{E:@catppuccin_status_cpu}"
      # set -agF status-right "#{E:@catppuccin_status_battery}"
      # set -g @catppuccin_window_middle_separator " "
      # set -g @catppuccin_window_current_text "#{window_name}"
      # set -g @catppuccin_window_default_text "#{window_name}"

      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi Y send-keys -X copy-selection-and-cancel

    '';
  };
}
