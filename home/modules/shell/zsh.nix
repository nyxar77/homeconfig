{ pkgs, ... }: {
  programs = {
    autojump.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    sesh = {
      enable = true;
      tmuxKey = "s";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      fileWidgetCommand = "fd --type f"; # ATT: for file search <C-T>
      fileWidgetOptions = [
        "--color='bg:,bg+:,spinner:#e965a5,hl:#b1baf4,fg:#eee9fc,header:#e965a5,info:#e965a5,pointer:#e965a5,marker:#e965a5,fg+:#e965a5,prompt:#e965a5,hl+:#ebde76,selected-bg:,border:#e965a5,label:#eee9fc'"
        "--preview 'bat --style=numbers --color=always {}'"
      ];
      # historyWidgetCommand = "fc -l 0"; #ATT: to search through history <C-R>
      # historyWidgetOptions = ["--sort" "--exact" "--color='bg:,bg+:,spinner:#e965a5,hl:#b1baf4,fg:#eee9fc,header:#e965a5,info:#e965a5,pointer:#e965a5,marker:#e965a5,fg+:#e965a5,prompt:#e965a5,hl+:#ebde76,selected-bg:,border:#e965a5,label:#eee9fc'"];
      colors = {
        bg = "";
        "bg+" = "";
        spinner = "#e965a5";
        hl = "#b1baf4";
        fg = "#eee9fc";
        header = "#e965a5";
        info = "#e965a5";
        pointer = "#e965a5";
        marker = "#e965a5";
        "fg+" = "#e965a5";
        prompt = "#e965a5";
        "hl+" = "#ebde76";
        "selected-bg" = "";
        border = "#e965a5";
        label = "#eee9fc";
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          arg0 = "fg=#b1f2a7,bold";
          command = "fg=#b1f2a7,bold";
          precommand = "fg=#b1f2a7,underline";
          path = "fg=#b3f4f3,underline";
          globbing = "fg=#b1baf4";
          redirection = "fg=#ebde76,bold";
          reserved-word = "fg=#ebde76,bold";
          single-quoted-argument = "fg=#ebde76";
          double-quoted-argument = "fg=#ebde76";
          back-dollar-quoted-argument = "fg=#b3f4f3";
          back-double-quoted-argument = "fg=#b3f4f3";
          unknown-token = "fg=#e965a5,bold";
          bracket-error = "fg=#e965a5,bold";
          comment = "fg=#938aad,italic";
        };
      };
      completionInit = ''
        autoload -Uz compinit
        compinit -C -d "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
      '';

      shellAliases = {
        ls = "eza --no-filesize";
      };

      initContent = ''
        setopt HIST_REDUCE_BLANKS
        eval "$(direnv hook zsh)"
        fastfetch
      '';
      # source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      history = {
        size = 10000;
        path = "$HOME/.zsh_history";
        ignoreAllDups = false;
        ignoreDups = true;
        ignoreSpace = false;

        ignorePatterns = [
          "rm *"
          "sudo rm *"
          "cp *"
          "sudo cp *"
          "kill *"
          "pkill *"
          "killall *"
          "dd *"
          "sudo dd *"
          "mkfs*"
          "sudo mkfs*"
          "wipefs *"
          "sudo wipefs *"
          "fdisk *"
          "parted *"
          "sgdisk *"
          "git reset --hard*"
          "git clean -f*"
        ];
      };

      plugins = [
        {
          name = "zsh-autocomplete";
          src = pkgs.zsh-autocomplete;
        }
      ];
    };
  };
}
