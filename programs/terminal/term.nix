{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
  };
  programs.autojump.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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
