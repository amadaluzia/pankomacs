;; -*- lexical-binding: t -*-


(defun config-init-ui ()
  (defun my/doom-modeline-for-new-frames (&optional frame)
    (setq doom-modeline-height (+ (frame-char-height) 8))
    (with-selected-frame (or frame (selected-frame))
      (doom-modeline-mode 1)))

  (use-package doom-modeline
    :defer t
    :commands (doom-modeline-mode)
    :custom
    (doom-modeline-mode (not (daemonp)))
    (doom-modeline-env-load-string "")
    :hook ((server-after-make-frame) . my/doom-modeline-for-new-frames)
    ;;     ^^^^^^^^^^^^^^^^^^^^^^^ this hook is my goat
    )

  (use-package base16-theme
    :config
    (load-theme 'base16-rose-pine t)))

(provide 'config-ui)
