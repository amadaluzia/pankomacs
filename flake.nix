{
  description = "Pankomacs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        {
          pkgs,
          self',
          config,
          system,
          ...
        }:
        let
          inherit (import ./emacs/mkEmacs.nix pkgs) mkEmacs;
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (import inputs.emacs)
            ];
          };

          packages = {
            pankomacs = mkEmacs (pkgs.emacs29-pgtk.override {
              withSystemd = false;
            });
            pankomacs-x11 = mkEmacs (pkgs.emacs-gtk.overide {
              withSystemd = false;
            });
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
