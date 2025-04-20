;; -*- lexical-binding: t -*-


(defun config-init-dev ()
  (use-package which-key
    :defer t
    :commands (which-key-mode)
    :custom
    (which-key-mode t))

  (use-package envrc
    :defer t
    :commands (envrc-global-mode envrc-mode)
    :custom
    (envrc-global-mode t))

  (use-package eglot
    :defer t
    :commands (eglot eglot-ensure)
    :hook (prog-mode . eglot-ensure)
    :config
    (add-to-list 'eglot-server-programs '((nim-mode nimscript-mode) . ("nimlsp")))))

(provide 'config-dev)
