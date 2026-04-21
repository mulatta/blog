{
  description = "blog.mulatta.io";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        ./nix/shell.nix
        ./nix/formatter.nix
        ./nix/packages.nix
      ];

      perSystem =
        {
          pkgs,
          lib,
          self',
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          checks =
            let
              packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
              devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
            in
            {
              inherit (self') formatter;
            }
            // packages
            // devShells
            // {
              link-check = pkgs.testers.lycheeLinkCheck {
                site = self'.packages.blog;
                remap = {
                  "https://blog.mulatta.io/" = "${self'.packages.blog}/";
                };
                extraConfig = {
                  base = "https://blog.mulatta.io/";
                  root_dir = "${self'.packages.blog}";
                  index_files = [ "index.html" ];
                  exclude_path = [
                    ".*/tags/.*"
                    ".*/categories/.*"
                  ];
                };
              };
            };
        };
    };

  inputs = {
    # keep-sorted start
    ai-robots-txt.flake = false;
    ai-robots-txt.url = "github:ai-robots-txt/ai.robots.txt";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    # keep-sorted end
  };
}
