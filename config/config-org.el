;;; config-org --- Configuration for Org-mode -*- lexical-binding: t -*-

;;; Commentary:

;; I need to do Org-mode configuration and this is
;; a decent place to do that.

;;; Code:
(defun init-org-config ()
  "Just provide Org-mode configuration."
  (defun my/org-mode-borders ()
    (modify-all-frames-parameters
     '((right-divider-width . 20)
       (internal-border-width . 20)))
    (dolist (face '(window-divider
                    window-divider-first-pixel
                    window-divider-last-pixel))
      (face-spec-reset-face face)
      (set-face-foreground face (face-attribute 'default :background)))
    (set-face-background 'fringe (face-attribute 'default :background)))
  (use-package org
    :custom
    ;; Edit settings
    (org-auto-align-tags nil)
    (org-tags-column 0)
    (org-fold-catch-invisible-edits 'show-and-error)
    (org-special-ctrl-a/e t)
    (org-insert-heading-respect-content t)

    ;; Org styling, hide markup etc.
    (org-hide-emphasis-markers t)
    (org-pretty-entities t)
    (org-agenda-tags-column 0)
    (org-ellipsis "…")
    :hook (org-mode . my/org-mode-borders))
  (use-package org-modern
    :hook (org-mode . org-modern-mode))
  (use-package org-bullets
    :hook org-mode))

(provide 'config-org)
;;; config-org.el ends here
