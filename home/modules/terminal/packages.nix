{pkgs, ...}: {
  programs.vim.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    colors = "always";
  };

  home.packages = with pkgs; [
    jq
    lazygit
    nurl
  ];

  programs = {
    command-not-found.enable = false;
    nix-index.enable = true;
  };
}
