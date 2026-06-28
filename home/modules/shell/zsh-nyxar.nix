{lib, ...}: {
  programs.zsh = {
    shellAliases = {
      k = "kubectl";
      hibernate = "sudo systemctl start hibernate.target";
      nixosconfig = "cd /etc/nixos; sudo -E nvim . ; cd -";
      nvimconfig = "cd ~/.config/nvim;nvim . ; cd -";
    };

    initContent = lib.mkOrder 550 ''
      eval "$(direnv hook zsh)"
    '';
  };
}
