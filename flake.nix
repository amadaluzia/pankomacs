{
  description = "Pankomacs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      systems = [
        "x86_64-linux"
      ];
      pkgsFor = inputs.nixpkgs.legacyPackages;
      forAllSystems = f: lib.genAttrs systems (system: f system pkgsFor.${system});
    in
    {
      lib = import ./lib.nix inputs;
      formatter = forAllSystems (_: pkgs: pkgs.nixfmt-rfc-style);
      packages = forAllSystems (
        _: pkgs: {
          pgtk = inputs.self.lib.mkPankomacs {
            inherit pkgs;
            emacs = pkgs.emacs30-pgtk;
          };
        }
      );
    };
}
