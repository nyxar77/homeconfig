{lib, ...}: {
  options.nyx.role = lib.mkOption {
    type = lib.types.enum ["desktop" "server"];
    description = "Role of this Home Manager configuration.";
  };
}
