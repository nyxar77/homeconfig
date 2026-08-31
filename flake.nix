{
  description = "Home Manager configuration of nyxar";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-extras = {
      # url = "path:/home/nyxar/Programming/projects/caelestia-extras";
      url = "github:nyxar77/caelestia-extras";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /*
         wallpapers = {
        url = "github:42willow/wallpapers";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    */
    /*
         ags = {
        url = "github:aylur/ags";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    */
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    projectorctl = {
      # url = "path:/home/nyxar/Programming/projects/projectorctl";
      url = "github:nyxar77/projectorctl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nyxar-nvim = {
      # url = "path:/home/nyxar/Programming/projects/neovimconfig";
      url = "github:nyxar77/neovimconfig";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    obsidian-extensions = {
      url = "github:karaolidis/nix-obsidian-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      flake =
        let
          hostSystem = "x86_64-linux";
          mkPkgs =
            system:
            import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
              overlays = [
                inputs.nur.overlays.default
                inputs.prismlauncher.overlays.default
                inputs.nyxar-nvim.overlays.default
                inputs.obsidian-extensions.overlays.default

                /*
                     (prev: final: {
                    cisco-packet-tracer = inputs.unstable.legacyPackages.${system}.ciscoPacketTracer8;
                  })
                */
              ];
            };

          mkHome =
            {
              username,
              system ? hostSystem,
              pkgs ? mkPkgs system,
              extraModules ? [ ],
              extraSpecialArgs ? { },
            }:
            let
              unstablePkgs = import inputs.unstable {
                inherit system;
                config.allowUnfree = true;
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;

              modules = [
                inputs.nix-index-database.homeModules.default
                inputs.nyxar-nvim.homeManagerModules.default
                ./home/modules/options.nix
                ./home/users/${username}
              ]
              ++ extraModules;

              extraSpecialArgs = {
                inherit inputs unstablePkgs;
              }
              // extraSpecialArgs;
            };
        in
        {
          homeConfigurations = {
            nyxar = mkHome {
              username = "nyxar";
              extraModules = [
                inputs.caelestia-shell.homeManagerModules.default
                inputs.caelestia-extras.homeModules.default
                inputs.projectorctl.homeManagerModules.default
                inputs.catppuccin.homeModules.catppuccin
              ];
              extraSpecialArgs = {
                inherit (inputs) spicetify-nix;
              };
            };

            baryon = mkHome {
              username = "baryon";
            };
          };
        };
    };
}
