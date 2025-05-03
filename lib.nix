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
            base16-theme
            doom-modeline
            nix-ts-mode
            flycheck
            org-bullets
            org-modern
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
