{
  description = "Pankomacs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: let
    lib = inputs.nixpkgs.lib.extend (import ./lib.nix);
  in
    inputs.parts.lib.mkFlake {
      inherit inputs;
      specialArgs.lib = lib;
    } {
      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        self',
        config,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (import inputs.emacs)
          ];
        };

        packages = builtins.mapAttrs (_: v:
          lib.mkEmacs {
            inherit pkgs;
            emacs = v;
          }) {
          pankomacs = pkgs.emacs30-pgtk;
          pankomacs-x11 = pkgs.emacs30-gtk3;
        };

        formatter = pkgs.alejandra;
      };
    };
}
