;; Package Manager:
(package-initialize)

(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'dancar-customize)
(require 'dancar-functions)
(require 'dancar-plugins)
(require 'dancar-keys)

(winner-mode 1)
;; full path in title
(setq frame-title-format
      (list
       "Emacs24 - "
       '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; Ding is annoying:
(setq ring-bell-function (lambda() nil))

;; Start emacs server when in windows system:
(when window-system (server-start))

;; Set font according to os:
;; old: Monaco
;; (cond
;;  ((equal system-type 'darwin)
;;   (set-face-attribute 'default nil :family "Menlo" :height 150 :weight 'normal))
;;  ((and nil (equal system-type 'gnu/linux))
;;   (set-face-attribute 'default nil :family "Ubuntu Mono" :height 180 :weight 'normal)))

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
(load-theme 'deeper-blue)
;; ;; (load-theme 'monokai)
;; ;; (load "~/.emacs.d/aanila/aanila-theme.el")
;; (require 'aanila-theme)

(auto-fill-mode -1)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; allow using the new gpg:
(setf epa-pinentry-mode 'loopback)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)


;; load personal stuff:
(let ((personal-file "~/Dropbox/private_emacs_config.el"))
  (if (file-exists-p personal-file) (load personal-file)))

(toggle-frame-maximized)
(helm-projectile-on)
(helm-recentf)
