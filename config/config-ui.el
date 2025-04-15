;; -*- lexical-binding: t -*-


(defun config-init-ui ()
  (defun my/doom-modeline-for-new-frames (&optional frame)
    (setq doom-modeline-height (+ (frame-char-height) 8))
    (with-selected-frame (or frame (selected-frame))
      (doom-modeline-refresh-bars)))

  (use-package doom-modeline
    :defer t
    :commands (doom-modeline-mode)
    :custom
    (doom-modeline-mode t)
    (doom-modeline-env-load-string "")
    (doom-modeline-height (+ (frame-char-height) 8))
    :hook (after-make-frame-functions . my/doom-modeline-for-new-frames))

  (use-package base16-theme
    :config
    (load-theme 'base16-rose-pine t)))

(provide 'config-ui)
