;; plugins: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package fill-column-indicator
  :config (add-hook 'typescript-mode-hook 'fci-mode)
  )


(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  )
(use-package guide-key
  :config
  (guide-key-mode 1)
  )

(use-package guide-key-tip
  :config
  (setq guide-key-tip/enabled nil)
  ;; (setq guide-key-tip/enabled t)
  )

(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
)

(use-package enh-ruby-mode
  :config
  (add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode) nil )
  )


(use-package typescript-mode
  :demand t
  :config
  (add-hook 'typescript-mode-hook (lambda () (yas-load-directory "/Users/dan/.emacs.d/snippets/typescript")(yas-reload-all)))
)


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
)
;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)


(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package tide
  :demand t
  :config
  (flycheck-add-mode 'typescript-tslint 'ng2-ts-mode)
  (flycheck-add-mode 'typescript-tide 'ng2-ts-mode)

  :after (typescript-mode company flycheck)
  :hook (
         (typescript-mode . tide-hl-identifier-mode)
  )
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
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


  :bind (
         )
  )


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
  (defun dancar-split-window-right ()
    (interactive)
    (split-window-right)
    (windmove-right)
    )

  (defun dancar-split-window-below ()
    (interactive)
    (split-window-below)
    (windmove-down)
    )
  (defun dancar-split-window-left ()
    (interactive)
    (split-window-right)
    )

  (defun dancar-split-window-above ()
    (interactive)
    (split-window-below)
    )
  :chords (
           ("`k" . windmove-up)
           ("`j" . windmove-down)
           ("`l" . windmove-right)
           ("`h" . windmove-left)

           ("`<up>" . windmove-up)
           ("`<down>" . windmove-down)
           ("`<right>" . windmove-right)
           ("`<left>" . windmove-left)

           ("`n" . delete-window)
           ("1n" . delete-other-windows)
           ("2n" . dancar-split-window-below)
           ("3n" . dancar-split-window-right)
           ("5n" . make-frame-command)
           ("0n" . delete-frame)

           ("2h" . dancar-split-window-left)
           ("2j" . dancar-split-window-below)
           ("2k" . dancar-split-window-above)
           ("2l" . dancar-split-window-right)
           ("qd" . tide-jump-to-definition)
           ("qp" . projectile-find-other-file)

               ))

(use-package tabbar-mode
  :bind (
    ("M-}" . tabbar-forward-tab)
    ("M-{" . tabbar-backward-tab)
    ("C-c k" . dancar-toggle-buffer-name-tabprefix)
    )
  :config
  ;; http://www.emacswiki.org/emacs/TabBarMode#toc4
  :init
  (defun dancar-tabbar-buffer-groups () (list "all"))


  (setq dancar-tabprefix "¶ ")

  (defun dancar-buffer-has-tabprefix (buffer-name)
    (equal (substring buffer-name 0 (length dancar-tabprefix)) dancar-tabprefix))

  (defun dancar-toggle-buffer-name-tabprefix ()
    (interactive)
    (if (dancar-buffer-has-tabprefix (buffer-name))
        (rename-buffer (substring (buffer-name) (length dancar-tabprefix)))
        (rename-buffer (concat dancar-tabprefix (buffer-name)))))

  (defun dancar-tabbar-buffers-list ()
    (remove-if
     (lambda (buffer)
       (not
        (or
         (eq buffer (current-buffer))
         (dancar-buffer-has-tabprefix (buffer-name buffer)))
        ))
       (buffer-list)))

  (setq tabbar-buffer-list-function 'dancar-tabbar-buffers-list)
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
(use-package let-alist)
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
  (treemacs-find-file)
  (treemacs-select-window)
  )

(use-package treemacs
  :config
  (progn
    (use-package treemacs-evil :ensure t :demand t)
    (use-package treemacs-projectile))
  :bind (("<f8>" . treemacs)
         ("C-x <f8>" . dancar-treemacs-f)
         ("H-r" . treemacs-refresh)))

;; (use-package virtualenvwrapper
;;   :config
;;   (setq venv-location "/Users/dan/.envs")
;;   (venv-workon "emacs"))

;; () (use-package elpy
;;   :config
;;   (elpy-enable)
;;   (define-key elpy-mode-map (kbd "<C-return>") nil)
;;   )

(use-package yafolding
  :config
  (define-key yafolding-mode-map (kbd "<C-S-return>") nil)
  (define-key yafolding-mode-map (kbd "<C-M-return>") nil)
  (define-key yafolding-mode-map (kbd "<C-return>") nil)
  (define-key yafolding-mode-map (kbd "C-c <C-M-return>") 'yafolding-toggle-all)
  (define-key yafolding-mode-map (kbd "C-c <C-S-return>") 'yafolding-hide-parent-element)
  (define-key yafolding-mode-map (kbd "C-c <C-return>") 'yafolding-toggle-element)
  (add-hook 'prog-mode-hook (lambda () (yafolding-mode)))
 )

(provide 'dancar-plugins)
;;; dancar-plugins ends here
