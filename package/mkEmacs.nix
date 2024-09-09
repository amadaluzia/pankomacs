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
      alwaysTangle = true;
      config = ./config.org;
      extraEmacsPackages =
        e:
        builtins.attrValues {
          inherit (e)
            nix-mode
            vertico
            orderless
            marginalia
            embark
            consult
            embark-consult
            consult-dir
            doom-modeline
            flycheck
            which-key
            lsp-mode
            lsp-ui
            lsp-pyright
            treemacs
            lsp-treemacs
            consult-lsp
            treemacs-icons-dired
            treemacs-nerd-icons
            nerd-icons
            all-the-icons
            projectile
            treemacs-projectile
            magit
            treemacs-magit
            rustic
            haskell-mode
            envrc
            ccls
            org-roam
            spacious-padding
            mood-line
            ement
            autothemer
            geiser-guile
            ;

          treesit-grammars = e.treesit-grammars.with-all-grammars;
          inherit (pkgs) python3;

          oxocarbon-theme = mkEmacsPackage e "oxocarbon-theme" "0.1.0" (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/konrad1977/emacs/main/themes/oxocarbon-theme.el";
            hash = "sha256-jD4DYc7aePuAF3m323YAi7jzE6ZpsSWb/zdmEgjFCns=";
          }) [ e.autothemer ];
        };
      override = _: prev: { use-package = prev.emacs; };
    };
}
