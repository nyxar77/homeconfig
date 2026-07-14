{config, ...}: {
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    EDITOR = "nvim";
    VISUAL = "nvim";
    USER = config.home.username;
    BROWSER = "firefox";
    NH_HOME_FLAKE = "${config.home.homeDirectory}/.config/home-manager#${config.home.username}";
  };
}
