;;; config.el --- my emacs configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Not much to gather here.

;;; Code:

(require 'config-ui)
(require 'config-org)
(require 'config-languages)

(defun init-config ()
  "The actual configuration to initialise at startup."
  (use-package emacs
    :init
    (setq frame-resize-pixelwise t
	  window-resize-pixelwise t
	  frame-inhibit-implied-resize t)
    :custom
    ;; vertico setup
    (read-extended-command-predicate #'command-completion-default-include-p)
    (minibuffer-prompt-properties
     '(read-only t cursor-intangible t face minibuffer-prompt))
    (enable-recursive-buffer t)
    (tab-always-indent 'complete)
    ;; essentials for me
    (delete-selection-mode t)
    (column-number-mode t)
    ;; get rid of unneeded ui elements
    (scroll-bar-mode nil)
    (tool-bar-mode nil)
    (menu-bar-mode nil)
    ;; get rid of the startup screen
    (initial-scratch-message nil)
    (inhibit-startup-screen t)
    :hook (prog-mode . display-line-numbers-mode))
  (use-package savehist
    :defer t
    :commands (savehist-mode)
    :custom
    (savehist-mode t))
  (use-package ibuffer
    :bind ("C-x C-b" . ibuffer))
  (use-package which-key
    :custom
    (which-key-mode t))
  (use-package icomplete
    :custom
    (fido-mode t)
    (icomplete-vertical-mode t))
  (use-package flycheck
    :custom
    (global-flycheck-mode t))
  (init-ui-config)
  (init-org-config)
  (init-languages-config))

(init-config)

(provide 'config)
;;; config.el ends here
