{ emacsWithPackagesFromUsePackage, fetchurl, emacs29-pgtk, python3 }:
emacsWithPackagesFromUsePackage {
  package = emacs29-pgtk;
  config = ./config.org;
  defaultInitFile = true;
  alwaysEnsure = true;
  alwaysTangle = true;
  extraEmacsPackages = e:
    let
      mkEmacsPackage =
        pname:
        src:
        deps:
        e.callPackage
          ({ trivialBuild }: trivialBuild {
            inherit pname src;
            version = "0.1.0";
            buildInputs = deps;
            propagatedUserEnvPkgs = deps;
          })
          { inherit (e) trivialBuild; };
    in
    (builtins.attrValues {
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
        ;

      treesit-grammars = e.treesit-grammars.with-all-grammars;
      inherit python3;
      oxocarbon = mkEmacsPackage "oxocarbon-theme"
        (fetchurl {
          url = "https://raw.githubusercontent.com/konrad1977/emacs/main/themes/oxocarbon-theme.el";
          hash = "sha256-jD4DYc7aePuAF3m323YAi7jzE6ZpsSWb/zdmEgjFCns=";
        }) [ e.autothemer ];
    });
  override = _: prev: { use-package = prev.emacs; };
}
