{pkgs, ...}: {
  imports = [
    ./term.nix
    ./tmux.nix
    ./starship.nix
    ./tealdeer.nix
    ./kitty.nix
  ];

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    colors = "always";
  };
  home.packages = with pkgs; [
    bat
    eza
    htop
    jq
    lazygit
    nurl
    nh
  ];
}
