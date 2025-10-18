{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
      set -g default-terminal "xterm-256color"

      unbind C-b
      set -g prefix C-q
      bind C-q send-prefix
      bind 'v' copy-mode # enable vim mode buy pressing <prefix> - v

      bind r source ~/.tmux.conf

      set -g mouse o


      # Split panes
      bind | split-window -h
      bind - split-window -v

      # Switch panes
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes
      bind H resize-pane -L 5
      bind J resize-pane -D 5
      bind K resize-pane -U 5
      bind L resize-pane -R 5


      # Switch to the previous window
      bind -n M-Left previous-window

      # Switch to the next window
      bind -n M-Right next-window

      # Rename window
      bind r command-prompt "rename-window %%"


      # Reload tmux config
      bind R source-file ~/.tmux.conf \; display-message "Config reloaded!"

      # Copy mode (easier for `azerty`)
      bind -T copy-mode-vi 'v' send-keys -X begin-selection
      BIND -T COPY-MODE-VI 'Y' SEND-KEYS -X COPY-SELECTION-AND-CANCEL

      set-window-option -g mode-keys vi
      set -s set-clipboard on
    '';
  };
}
