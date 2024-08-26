{ symlinkJoin, emacsWithPackagesFromUsePackage, emacs29-pgtk, python3, texliveFull, makeWrapper, lib }:
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
          ;
      }) ++ [
        e.treesit-grammars.with-all-grammars
        python3
      ];
    override = _: prev: { use-package = prev.emacs; };
  };
in
symlinkJoin {
  name = "emacs";
  paths = [ texliveFull emacs-linux ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin
    wrapProgram $out/bin/emacs \
      --set PATH ${lib.makeBinPath [ texliveFull ]}:$PATH
  '';
}
