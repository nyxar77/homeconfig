{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
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

    shellInit = ''
      fastfetch
      aj() {
          cd "$(autojump $1)"
      }
    '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
  };
}
