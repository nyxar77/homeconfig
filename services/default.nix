{...}: {
  imports = [
    ./podman.nix
    ./ssh.nix
    ./general.nix
  ];

  programs.ssh.enable = true;
}
