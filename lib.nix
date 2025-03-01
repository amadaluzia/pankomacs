{inputs, ...}: {
  flake.lib = inputs.nixpkgs.lib.extend (_: _: let
    mkEmacsPackage = {
      epkgs,
      pname,
      version,
      src,
      deps ? [],
    }:
      epkgs.callPackage (
        {trivialBuild}:
          trivialBuild {
            inherit pname version src;
            buildInputs = deps;
            propagatedUserEnvPkgs = deps;
          }
      ) {inherit (epkgs) trivialBuild;};

    mkEmacs = {
      pkgs,
      emacs,
    }:
      (pkgs.appendOverlays [inputs.emacs.overlays.default]).emacsWithPackagesFromUsePackage {
        package = emacs;
        defaultInitFile = true;
        config = ./config.el;
        extraEmacsPackages = epkgs:
          builtins.attrValues {
            inherit
              (epkgs)
              spacious-padding
              doom-modeline
              helm
              base16-theme
              nix-mode
              rust-mode
              haskell-mode
              qml-mode
              envrc
              vterm
              ;
            treesit-grammars = epkgs.treesit-grammars.with-all-grammars;
          };
        override = _: prev:
          builtins.listToAttrs (map (name: {
              inherit name;
              value = prev.emacs;
            }) [
              "use-package"
              "savehist"
              "which-key"
            ]);
      };
  in {
    inherit mkEmacs mkEmacsPackage;
  });
}
