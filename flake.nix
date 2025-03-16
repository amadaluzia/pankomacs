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
      forAllSystems = lib.genAttrs systems;
      pkgs = builtins.listToAttrs (
        map (system: {
          name = system;
          value = import inputs.nixpkgs {
            inherit system;
          };
        }) systems
      );
    in
    {
      lib = import ./lib.nix inputs;
      formatter = forAllSystems (system: pkgs.${system}.nixfmt-rfc-style);
      packages = forAllSystems (system: {
        pgtk = inputs.self.lib.mkPankomacs {
          pkgs = pkgs.${system};
          emacs = pkgs.${system}.emacs30-pgtk;
        };
      });
    };
}
