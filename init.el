;; Package Manager:
(package-initialize)

(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'dancar-customize)
(require 'dancar-functions)
(require 'dancar-keys)

;; full path in title
(setq frame-title-format
      (list
       "Emacs24 - "
       '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; Ding is annoying:
(setq ring-bell-function (lambda() (message "Beep.")))

;; Start emacs server when in windows system:
(when window-system (server-start))

;; Set font according to os:
(cond
 ((equal system-type 'darwin)
  (set-face-attribute 'default nil :family "Monaco" :height 130 :weight 'normal))
 ((and nil (equal system-type 'gnu/linux))
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 180 :weight 'normal)))

;; Disable truncating lines when viewing diffs in ediff:
(add-hook 'ediff-prepare-buffer-hook (lambda () (toggle-truncate-lines 0)))

;; Enable erasing complete buffers:
(put 'erase-buffer 'disabled nil)

;; Delete trailing whitespace upon save:
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Read the bash profile when entering shell:
(add-hook 'shell-mode-hook>
          (lambda ()
            (insert "source ~/.profile")
            (comint-send-input)))

;; load color-theme:
(load-theme 'manoj-dark)

(auto-fill-mode -1)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; plugins:

(use-package helm-ls-git)

(use-package tabbar-mode
  :bind (
    ("s-}" . tabbar-forward-tab)
    ("s-{" . tabbar-backward-tab)
    ("C-s-{" . tabbar-backward-group)
    ("C-s-}" . tabbar-forward-group))
  :config
  ;; http://www.emacswiki.org/emacs/TabBarMode#toc4
  (defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group
    "Returns the name of the tab group names the current buffer belongs to.
 There are two groups: Emacs buffers (those whose name starts with '*', plus
 dired buffers), and the rest.  This works at least with Emacs v24.2 using
 tabbar.el v1.7."
    (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs")
                ((eq major-mode 'dired-mode) "Dired")
                ((eq major-mode 'markdown-mode) "Markdown")
                (t "User"))))
  (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
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

(require 'dancar-evil)

 (use-package powerline
   :config
   (require 'dancar-powerline)
   )

(toggle-frame-maximized)
