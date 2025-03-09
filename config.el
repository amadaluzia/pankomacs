;; -*- lexical-binding: t -*-

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
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq inhibit-splash-screen t
	inhibit-startup-screen t
	initial-scratch-message nil
	enable-recursive-minibuffers t
	read-extended-command-predicate #'command-completion-default-include-p
	tab-always-indent 'complete)
  :hook (prog-mode . display-line-numbers-mode))

(use-package mood-line
  :hook (after-init . mood-line-mode))

(use-package helm
  :bind (("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 ("M-s o" . helm-occur)
	 ("C-h a" . helm-apropos))
  :hook (after-init . helm-mode))

(use-package savehist
  :hook (after-init . savehist-mode))

(use-package which-key
  :hook (after-init . which-key-mode))

(use-package base16-theme
  :config
  (load-theme 'base16-everforest-dark-hard t))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package qml-mode
  :mode "\\.qml\\'")

(use-package haskell-mode
  :mode "\\.hs\\'")

(use-package python
  :config
  (setq python-indent-offset 4))

(use-package cc-mode
  :config
  (setq c-basic-offset 4))

(use-package vterm
  :preface
  (defun project-vterm (&optional arg)
    (interactive)
    (let* ((default-directory (project-root (project-current 1)))
	   (vterm-buffer-name (project-prefixed-buffer-name "vterm")))
      (vterm arg)))
  :bind (("C-x p t" . project-vterm)
	 ("C-c t" . vterm)))

(use-package spacious-padding
  :config
  (spacious-padding-mode)
  )

(provide 'config)
