{ pkgs, ... }:
let
  mkEmacsPackage =
    {
      epkgs,
      pname,
      version,
      src,
      deps ? [ ],
    }:
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
      config = ./config.el;
      extraEmacsPackages =
        epkgs:
        builtins.attrValues {
          inherit (epkgs)
            spacious-padding
            mood-line
            which-key
            helm
            base16-theme
            nix-mode
            rust-mode
            haskell-mode
            envrc
            eat
            vterm
            ;
          treesit-grammars = epkgs.treesit-grammars.with-all-grammars;
        };
      override = _: prev: {
        use-package = prev.emacs;
        savehist = prev.emacs;
      };
    };
}
