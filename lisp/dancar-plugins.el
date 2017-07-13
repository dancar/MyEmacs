;; plugins: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode) nil )
  )

(use-package rjsx-mode
  :config
  (setq dancar-js-indent-level js-indent-level)
  (add-hook 'rjsx-mode-hook (lambda () (setq js-indent-level dancar-js-indent-level)))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode) nil )
  ;; (define-key rjsx-mode-map "<" nil)
  )
(use-package helm-projectile
  :config
  (projectile-mode)
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)

  :bind (
         ("C-x C-\\" . helm-projectile-find-file)
         ("C-x C-|" . helm-projectile-switch-project)
         )
  )

(use-package neotree
  :init (defun dancar-neotree-f ()
          (interactive)
          (neotree-find (buffer-file-name)))
  (define-key neotree-mode-map (kbd "H-r") 'neotree-refresh)

  :bind (("<f8>" . neotree-toggle)
         ("C-x <f8>" . dancar-neotree-f)
         :map neotree-mode-map
         ("H-r" . neotree-refresh)))
(use-package drag-stuff
  :bind (
         ("M-n" . drag-stuff-down)
         ("M-p" . drag-stuff-up)
         )
  )

(use-package helm-mode
  :config
  (helm-mode 1)
  )


(use-package helm-ls-git)

(require 'use-package-chords)
(use-package key-chord
  :config
  (key-chord-mode 1)
  :chords (("`1" . save-buffer)
           ))


(use-package tabbar-mode
  :bind (
    ("M-}" . tabbar-forward-tab)
    ("M-{" . tabbar-backward-tab)
    ("C-M-{" . tabbar-backward-group)
    ("C-M-}" . tabbar-forward-group))
  :config
  ;; http://www.emacswiki.org/emacs/TabBarMode#toc4
  :init
  (defun dancar-tabbar-buffer-groups () ;; customize to show all normal files in one group
    "Returns the name of the tab group names the current buffer belongs to.
 There are two groups: Emacs buffers (those whose name starts with '*', plus
 dired buffers), and the rest.  This works at least with Emacs v24.2 using
 tabbar.el v1.7."
    (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs")
                ((eq major-mode 'dired-mode) "Dired")
                ((eq major-mode 'markdown-mode) "Markdown")
                (t "User"))))
  (setq tabbar-buffer-groups-function 'dancar-tabbar-buffer-groups)
  )

(use-package deft
  :config
  ;; configuration based on http://emacs-fu.blogspot.co.il/2011/09/quick-note-taking-with-deft-and-org.html
  (setq
   deft-extension "org"
   deft-directory "~/Dropbox/deft/"
   deft-text-mode 'org-mode)
)

(use-package expand-region
  :bind (
         ("C-=" . er/expand-region)
         ("C-+" . er/contract-region)
         ))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (mapcar 'exec-path-from-shell-copy-env '())
  )

(use-package evil
  :config
  (require 'dancar-evil)
  (evil-mode 1)
  )

(use-package powerline
  :config
  (require 'dancar-powerline)
  )

(use-package company
  :config
  (global-company-mode)
  (add-hook 'after-init-hook 'global-company-mode)
  :bind
  (("C-M-<SPC>" . company-complete))
  )
(provide 'dancar-plugins)
;;; dancar-plugins ends here
