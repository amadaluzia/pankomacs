inputs:
let
  mkPankomacs =
    {
      pkgs,
      emacs,
    }: let
      pkgsWithEmacsOverlay = pkgs.appendOverlays [ inputs.emacs.overlays.default ];
    in
    pkgsWithEmacsOverlay.emacsWithPackagesFromUsePackage {
      package = emacs;
      defaultInitFile = true;
      config = ./config.el;
      extraEmacsPackages =
        epkgs:
        builtins.attrValues {
          inherit (epkgs)
            spacious-padding
            doom-modeline
            ivy
            counsel
            swiper
            base16-theme
            nix-ts-mode
            rust-mode
            haskell-mode
            qml-mode
            tuareg
            nushell-mode
            nim-mode
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
  inherit mkPankomacs;
}
