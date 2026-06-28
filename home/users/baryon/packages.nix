{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    curl
    dig
    duf
    dust
    micro
    ncdu
    rsync
    tree
  ];
}
