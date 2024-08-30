{ emacsWithPackagesFromUsePackage, emacs29-pgtk, python3 }:
let
  emacs-linux = emacsWithPackagesFromUsePackage {
  package = emacs29-pgtk;
    config = ./config.org;
    defaultInitFile = true;
    alwaysEnsure = true;
    alwaysTangle = true;
    extraEmacsPackages =
      e: (builtins.attrValues {
        inherit (e)
          nix-mode
          doom-themes
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
          ;
      }) ++ [
        e.treesit-grammars.with-all-grammars
        python3
      ];
    override = _: prev: { use-package = prev.emacs; };
  };
in
emacs-linux
