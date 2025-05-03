;;; config-languages --- Language configuration -*- lexical-binding: t -*-

;;; Commentary:

;; I need to provide configuration for things like
;; Nix, Nim, etc. so why not just write it down
;; here?

;;; Code:
(defun init-languages-config ()
  "Just provide some language configuration."
  (use-package nix-ts-mode
    :mode "\\.nix\\'"))

(provide 'config-languages)
;;; config-languages.el ends here
