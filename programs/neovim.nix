{...}: {
  programs.neovim = {
    enable = false;
    /*
       plugins = with pkgs.vimPlugins; [
      yankring
      vim-nix
      {
        plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
    ];
    */
    # extraConfig = builtins.readFile ../../nvim/init.lua;
  };
}
