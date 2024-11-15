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
  (inhibit-startup-screen t)
  (inhibit-splash-screen t)
  (initial-scratch-message nil)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (tab-always-indent 'complete)
  :config
  (setq-default mode-line-format nil)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  :hook ((prog-mode . display-line-numbers-mode)
	 (text-mode . display-line-numbers-mode)))

(use-package spacious-padding
  :init
  (spacious-padding-mode))

(use-package nano-modeline
  :hook ((prog-mode . nano-modeline-prog-mode)
	 (text-mode . nano-modeline-text-mode)
	 (org-mode . nano-modeline-org-mode)
	 (org-capture-mode . nano-modeline-org-capture-mode)
	 (org-agenda-mode . nano-modeline-org-agenda-mode)))

(use-package helm
  :bind (("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 ("M-s o" . helm-occur)
	 ("C-h a" . helm-apropos))
  :config
  (helm-mode 1))
	 
(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :init (which-key-mode))

(use-package base16-theme
  :init
  (load-theme 'base16-rose-pine t))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package qml-ts-mode
  :mode "\\.qml\\'")

(use-package haskell-mode
  :mode "\\.hs\\'")

(provide 'config)
