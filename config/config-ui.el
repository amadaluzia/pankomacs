;;; config-ui --- UI configuration -*- lexical-binding: t -*-

;;; Commentary:

;; I need to do UI configuration and this is a
;; decent place to do that.

;;; Code:

(defun init-ui-config ()
  "Just provide UI configuration."
  (use-package base16-theme
    :config
    (load-theme 'base16-rose-pine t))
  (use-package doom-modeline
    :custom
    (doom-modeline-mode t)))

(provide 'config-ui)
;;; config-ui.el ends here
