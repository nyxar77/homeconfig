{config, ...}: {
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    EDITOR = "nvim";
    VISUAL = "nvim";
    NH_HOME_FLAKE = "${config.home.homeDirectory}/.config/home-manager#${config.home.username}";
  };
}
