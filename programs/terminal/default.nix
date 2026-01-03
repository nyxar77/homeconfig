{pkgs, ...}: {
  imports = [
    ./term.nix
    ./tmux.nix
    ./starship.nix
    ./tealdeer.nix
    ./kitty.nix
    ./fastfetch.nix
    ./cava.nix
    ./bat.nix
  ];

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    colors = "always";
  };
  home.packages = with pkgs; [
    eza
    htop
    jq
    lazygit
    nurl
    nh
    qpdf
  ];
}
