;; Package Manager:
(package-initialize)

(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d/lisp")
 (require 'dancar-customize)
 (require 'dancar-functions)
 (require 'dancar-plugins)
 (require 'dancar-keys)



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
(add-hook 'shell-mode-hook
          (lambda ()
            (insert "source ~/.profile")
            (comint-send-input)))

;; load color-theme:
(load-theme 'manoj-dark)

(auto-fill-mode -1)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet web-mode undo-tree tabbar smex scss-mode paredit org nyan-mode multiple-cursors markdown-mode magit key-chord json-mode js3-mode js2-mode ivy ido-ubiquitous idle-highlight-mode highlight-symbol expand-region exec-path-from-shell deft color-theme buffer-move auto-complete ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
