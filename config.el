; -*- lexical-binding: t -*-

(use-package emacs
  :init
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
  (inhibit-splash-screen t)
  (inhibit-startup-screen t)
  (initial-scratch-message nil)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (tab-always-indent 'complete)
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  :hook (prog-mode . display-line-numbers-mode))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

(use-package helm
  :bind (("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 ("M-s o" . helm-occur)
	 ("C-h a" . helm-apropos))
  :init
  (helm-mode 1))
	 
(use-package savehist
  :init
  (savehist-mode 1))

(use-package which-key
  :init (which-key-mode 1))

(use-package base16-theme
  :init
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
  :custom
  (python-indent-offset 4))

(use-package cc-mode
  :custom
  (c-basic-offset 4))

(use-package vterm
  :preface
  (defun project-vterm (&optional arg)
    (interactive)
    (let* ((default-directory (project-root (project-current 1)))
	   (vterm-buffer-name (project-prefixed-buffer-name "vterm")))
      (vterm arg)))
  :bind (("C-x p t" . project-vterm)
	 ("C-c t" . vterm)))

(provide 'config)
