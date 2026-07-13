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
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prefer_editor_prompt = "disabled";

      prompt = "enabled";

      color_labels = "disabled";
      accessible_colors = "disabled";
      accessible_prompter = "disabled";
      spinner = "enabled";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
    /*
       hosts = {
      "github.com" = {
        user = "nyxar77";
      };
    };
    */
  };
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
