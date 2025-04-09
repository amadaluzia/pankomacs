inputs:
let
  pkgsWithEmacsOverlay =
    system:
    inputs.nixpkgs.legacyPackages.${system}.appendOverlays [
      inputs.emacs.overlays.default
    ];
  mkPankomacs =
    {
      pkgs,
      emacs,
    }:
    (pkgsWithEmacsOverlay pkgs.stdenv.system).emacsWithPackagesFromUsePackage {
      config = ./config/config.el;
      defaultInitFile = true;
      package = emacs;
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
          config = epkgs.trivialBuild {
            name = "config-${inputs.self.shortRev or "dirty"}";
            src = ./config;
          };
        };
    };
in
{
  inherit mkPankomacs;
}
