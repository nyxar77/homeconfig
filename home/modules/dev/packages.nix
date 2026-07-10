{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    nixfmt
    mongosh
    nix-tree
    codebook
    insomnia
    jetbrains.idea-oss
    devenv
  ];
  programs.git.enable = true;
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "nyxar77";
        email = "dev@nyxar.space";
      };
      ui = {
        color = "auto";
        editor = "nvim";
      };
    };
  };
}
