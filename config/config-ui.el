;; -*- lexical-binding: t -*-


(defun config-init-ui ()
  (use-package doom-modeline
    :defer t
    :commands (doom-modeline-mode)
    :custom
    (doom-modeline-mode t)
    (doom-modeline-height 26))

  (use-package base16-theme
    :config
    (load-theme 'base16-rose-pine t)))

(provide 'config-ui)
