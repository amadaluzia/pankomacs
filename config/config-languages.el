;; -*- lexical-binding: t -*-

(defun config-init-languages ()
  (use-package nix-ts-mode
    :defer t
    :commands (nix-ts-mode)
    :mode "\\.nix\\'")

  (use-package rust-ts-mode
    :defer t
    :commands (rust-ts-mode)
    :mode "\\.rs\\'")

  (use-package qml-mode
    :defer t
    :commands (qml-mode)
    :mode "\\.qml\\'")

  (use-package haskell-mode
    :defer t
    :commands (haskell-mode)
    :mode "\\.hs\\'")

  (use-package python
    :defer t
    :commands (python-ts-mode python-mode)
    :custom
    (python-indent-offset 4))

  (use-package cc-mode
    :defer t
    :commands (c-ts-mode
	       c++-ts-mode
	       c++-mode
	       c-mode)
    :custom
    (c-basic-offset 4))

  (use-package nushell-mode
    :defer t
    :commands (nushell-mode)
    :mode "\\.nu\\'")

  (use-package tuareg
    :defer t
    :commands (tuareg-mode tuareg-opam-mode)
    :mode "\\.ml\\'")

  (use-package nim-mode
    :defer t
    :commands (nim-mode)
    :mode (("\\.nim\\'" . nim-mode)
	   ("\\.nims\\'" . nimscript-mode)))

  (use-package go-ts-mode
    :defer t
    :commands (go-ts-mode go-mod-ts-mode)
    :mode (("\\.go\\'" . go-ts-mode)
	   ("go.mod\\'" . go-mod-ts-mode))))

(provide 'config-languages)
