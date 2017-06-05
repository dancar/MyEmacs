;; plugins: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm-projectile
  :config
  (projectile-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)

  :bind (
         ("C-x C-\\" . helm-projectile-find-file)
         ("C-x C-|" . helm-projectile-switch-project)
         )
  )
(use-package neotree
  :bind ( ("<f8>" . neotree-toggle) )
  )
(use-package drag-stuff
  :bind (
         ("s-n" . drag-stuff-down)
         ("s-p" . drag-stuff-up)
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

           )
           ("jh" . dancar-jump-line-next-small)
           ("JH" . dancar-jump-line-next-big)

           ("kl" . dancar-jump-line-previous-small)
           ("KL" . dancar-jump-line-previous-big)
  )

(use-package tabbar-mode
  :bind (
    ("s-}" . tabbar-forward-tab)
    ("s-{" . tabbar-backward-tab)
    ("C-s-{" . tabbar-backward-group)
    ("C-s-}" . tabbar-forward-group))
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
  (add-hook 'after-init-hook 'global-company-mode)
  :bind
  (("C-s-<268632064>" . company-complete))
  )
(provide 'dancar-plugins)
