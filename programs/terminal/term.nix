{
  pkgs,
  lib,
  ...
}: {
  programs.autojump.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetCommand = "fd --type f"; #ATT: for file search <C-T>
    fileWidgetOptions = ["--color='bg:,bg+:,spinner:#e965a5,hl:#b1baf4,fg:#eee9fc,header:#e965a5,info:#e965a5,pointer:#e965a5,marker:#e965a5,fg+:#e965a5,prompt:#e965a5,hl+:#ebde76,selected-bg:,border:#e965a5,label:#eee9fc'" "--preview 'bat --style=numbers --color=always {}'"];
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    completionInit = "autoload -U compinit && compinit";

    shellAliases = {
      k = "kubectl";
      hibernate = "sudo systemctl start hibernate.target";
      nixosconfig = "cd /etc/nixos; sudo -E nvim . ; cd -";
      nvimconfig = "cd ~/.config/nvim;nvim . ; cd -";
      ls = "eza --icons=always --color=always -l --no-filesize";
      ll = "eza --icons=always --color=always -la";
      tree = "eza --tree --icons=always --color=always -l --no-filesize";
    };

    initContent = lib.mkOrder 550 ''
      fastfetch
      aj() {
          cd "$(autojump $1)"
      }
      eval "$(direnv hook zsh)"
    '';

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
    ];
  };
}
