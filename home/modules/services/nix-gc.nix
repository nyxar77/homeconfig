{lib, ...}: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = lib.mkDefault "--delete-older-than 15d";
    };
  };
}
