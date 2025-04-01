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

(use-package ivy
  :custom
  (ivy-use-virtual-buffers t)
  :bind (("C-s" . swiper-isearch)
         ("C-c C-r" . ivy-resume)
         ("<f6>" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> o" . counsel-describe-symbol)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char)
         ("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c k" . counsel-ag)
         ("C-x l" . counsel-locate)
         ("C-S-o" . counsel-rhythmbox)
	 :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history))
  :hook after-init)

(use-package savehist
  :hook after-init)

(use-package which-key
  :hook after-init)

(use-package base16-theme
  :config
  (load-theme 'base16-tokyo-night-dark t))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package rust-mode
  :mode "\\.rs\\'")

(when (executable-find "direnv")
  (use-package envrc
    :hook after-init))

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

(use-package nushell-mode
  :mode "\\.nu\\'")

(use-package tuareg
  :mode "\\.ml\\'")

(use-package nim-mode
  :mode "\\.nim\\'")

(use-package doom-modeline
  :hook after-init)

(provide 'config)
