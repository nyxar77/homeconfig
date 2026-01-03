{
  description = "Home Manager configuration of nyxar";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.nur.overlays.default
        /*
           (prev: final: {
          cisco-packet-tracer = inputs.unstable.legacyPackages.${system}.ciscoPacketTracer8;
        })
        */
      ];
    };
    unstablePkgs = import inputs.unstable {
      inherit system;
    };
  in {
    homeConfigurations."nyxar" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
      ];

      extraSpecialArgs = {
        inherit (inputs) stylix spicetify-nix;
        inherit inputs;
        inherit unstablePkgs;
      };

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
