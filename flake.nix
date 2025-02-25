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
  outputs = inputs:
    inputs.parts.lib.mkFlake {
      inherit inputs;
    } {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./lib.nix
      ];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
        packages = {
          pgtk = inputs.self.lib.mkEmacs {
            inherit pkgs;
            emacs = pkgs.emacs30-pgtk;
          };
        };
      };
    };
}
