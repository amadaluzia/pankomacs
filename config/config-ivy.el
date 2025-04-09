;; -*- lexical-binding: t -*-


(defun config-init-ivy ()
  (use-package ivy
    :custom
    (ivy-mode t)
    (counsel-mode t)
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
           ("C-r" . counsel-minibuffer-history))))

(provide 'config-ivy)
