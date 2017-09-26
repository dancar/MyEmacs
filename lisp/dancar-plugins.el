;; plugins: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode) nil )
  )
(use-package typescript-mode
  :config
  (add-hook 'typescript-mode-hook (lambda () (yas-load-directory "/Users/dan/.emacs.d/snippets/typescript")(yas-reload-all)))
)
;;;; stolen from https://debbugs.gnu.org/cgi/bugreport.cgi?bug=24896
(defvar js-jsx-tag-syntax-table
  (let ((table (make-syntax-table sgml-tag-syntax-table)))
    (modify-syntax-entry ?\{ "<" table)
    (modify-syntax-entry ?\} ">" table)
    table))
(defun advice-js-jsx-indent-line (orig-fun)
  (interactive)
  (let ((sgml-tag-syntax-table js-jsx-tag-syntax-table))
    (apply orig-fun nil)))
(advice-add 'js-jsx-indent-line :around 'advice-js-jsx-indent-line)

(use-package rjsx-mode
  :config
  (setq dancar-js-indent-level js-indent-level)
  (add-hook 'rjsx-mode-hook (lambda () (setq js-indent-level dancar-js-indent-level)))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode) nil )
  ;; (define-key rjsx-mode-map "<" nil)
  )

;; (use-package helm-fuzzier
;;   :config
;;   (helm-fuzzier-mode 1)
;;   )

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

;; (use-package neotree
;;   :init (defun dancar-neotree-f ()
;;           (interactive)
;;           (let ((bfn (buffer-file-name)))
;;             (neotree-dir (projectile-project-root))
;;             (neotree-find bfn)))
;;   :config
;;   (define-key neotree-mode-map (kbd "H-r") 'neotree-refresh)

;;   :bind (("<f8>" . neotree-toggle)
;;          ("C-x <f8>" . dancar-neotree-f)
;;          :map neotree-mode-map
;;          ("H-r" . neotree-refresh)))

(use-package drag-stuff
  :bind (
         ("M-n" . drag-stuff-down)
         ("M-p" . drag-stuff-up)
         )
  )

(use-package helm-mode
  :config
  (helm-mode 1)
  :bind (("M-x" . helm-M-x))
  )


(use-package helm-ls-git)

(require 'use-package-chords)
(use-package key-chord
  :config
  (key-chord-mode 1)
  :chords (("`1" . save-buffer)

           ("`k" . windmove-up)
           ("`j" . windmove-down)
           ("`l" . windmove-right)
           ("`h" . windmove-left)

           ("`<up>" . windmove-up)
           ("`<down>" . windmove-down)
           ("`<right>" . windmove-right)
           ("`<left>" . windmove-left)

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

(defun dancar-treemacs-f ()
  (interactive)
  (let ((bfn (buffer-file-name)))
    (treemacs--init (projectile-project-root))
    (treemacs-find-file bfn)))

(use-package treemacs
  :config
  (progn
    (use-package treemacs-evil :ensure t :demand t)
    (use-package treemacs-projectile))
  :bind (("<f8>" . treemacs-projectile-toggle)
         ("C-x <f8>" . dancaretreemacs-f)
         ("H-r" . treemacs-refresh)))

(provide 'dancar-plugins)
;;; dancar-plugins ends here
