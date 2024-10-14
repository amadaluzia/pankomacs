{ pkgs, ... }:
let
  mkEmacsPackage =
    epkgs: pname: version: src: deps:
    epkgs.callPackage (
      { trivialBuild }:
      trivialBuild {
        inherit pname version src;
        buildInputs = deps;
        propagatedUserEnvPkgs = deps;
      }
    ) { inherit (epkgs) trivialBuild; };
in
{
  mkEmacs =
    emacs:
    pkgs.emacsWithPackagesFromUsePackage {
      package = emacs;
      defaultInitFile = true;
      alwaysEnsure = true;
      config = ./config.el;
      extraEmacsPackages =
        e:
        builtins.attrValues {
          inherit (e)
            spacious-padding
            nano-modeline
            orderless
            corfu
            which-key
            marginalia
            vertico
            consult
            embark
            embark-consult
      	    base16-theme
            nix-mode
            rust-mode
            envrc
            ;
          treesit-grammars = e.treesit-grammars.with-all-grammars;
        };
      override = _: prev: { use-package = prev.emacs; };
    };
}
