;;; config.el --- my emacs configuration -*- lexical-binding: t -*-

;; Author: Artur Manuel
;; URL: https://copeberg.org/amadaluzia/pankomacs
;; Version: 0.0.0

;;; Commentary:

;; All this does is provide a configuration for Emacs to use.

;;; Code:

(require 'config-ui)
(require 'config-dev)
(require 'config-ivy)
(require 'config-languages)
(require 'use-package)

(defun config-initialise ()
  (config-init-dev)
  (config-init-ui)
  (config-init-languages)
  (config-init-ivy)
  (use-package emacs
    :init
    (setq frame-resize-pixelwise t
	  window-resize-pixelwise t
	  frame-inhibit-implied-resize t)
    (defun crm-indicator (args)
      (cons (format "[CRM%s] %s"
                    (replace-regexp-in-string
                     "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                     crm-separator)
                    (car args))
            (cdr args)))
    (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
    (setq minibuffer-prompt-properties
          '(read-only t cursor-intangible t face minibuffer-prompt))
    (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
    :custom
    (initial-scratch-message nil)
    (inhibit-startup-screen t)
    (inhibit-splash-screen t)
    (menu-bar-mode nil)
    (tool-bar-mode nil)
    (scroll-bar-mode nil)
    (delete-selection-mode t)
    (column-number-mode t)
    (enable-recursive-buffer t)
    (read-extended-command-predicate #'command-completion-default-include-p)
    (tab-always-indent 'complete)
    :hook (prog-mode . display-line-numbers-mode))

  (use-package savehist
    :defer t
    :commands (savehist-mode)
    :custom
    (savehist-mode t)))

(add-hook #'after-init-hook #'config-initialise)

(provide 'config)

;;; config.el ends here
