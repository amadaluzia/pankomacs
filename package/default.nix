{ emacsWithPackagesFromUsePackage, emacs29-pgtk }:
emacsWithPackagesFromUsePackage {
  package = emacs29-pgtk;
  config = ./config.org;
  defaultInitFile = true;
  alwaysEnsure = true;
  alwaysTangle = true;
  extraEmacsPackages =
    e: with e; [
      treesit-grammars.with-all-grammars
      nix-ts-mode
      base16-theme
      vertico
      orderless
      marginalia
      embark
      consult
      embark-consult
      consult-dir
      doom-modeline
      nerd-icons
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
    ];
  override = _: prev: { use-package = prev.emacs; };
}
