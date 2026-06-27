{lib, ...}: {
  nix = {
    gc = {
      automatic = true;
      # frequency = "weekly";
      options = lib.mkDefault "--delete-older-than 15d";
    };
  };
}
