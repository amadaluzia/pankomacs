inputs:
let
  mkEmacsPackage =
    {
      epkgs,
      pname,
      version,
      src,
      deps ? (epkgs: [ ]),
    }:
    epkgs.trivialBuild {
      inherit pname version src;
      buildInputs = deps epkgs;
      propagatedUserEnvPkgs = deps epkgs;
    };

  mkPankomacs =
    {
      pkgs,
      emacs,
    }:
    (pkgs.appendOverlays [ inputs.emacs.overlays.default ]).emacsWithPackagesFromUsePackage {
      package = emacs;
      defaultInitFile = true;
      config = ./config.el;
      extraEmacsPackages =
        epkgs:
        builtins.attrValues {
          inherit (epkgs)
            spacious-padding
            mood-line
            helm
            base16-theme
            nix-mode
            rust-mode
            haskell-mode
            qml-mode
            tuareg
            envrc
            ;
          treesit-grammars = epkgs.treesit-grammars.with-all-grammars;
        };
      override =
        _: prev:
        builtins.listToAttrs (
          map
            (name: {
              inherit name;
              value = prev.emacs;
            })
            [
              "use-package"
              "savehist"
              "which-key"
            ]
        );
    };
in
{
  inherit mkPankomacs mkEmacsPackage;
}
