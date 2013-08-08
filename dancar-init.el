(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d")
(require 'dancar-customize)
(require 'dancar-functions)
(require 'dancar-keys)
(require 'dancar-plugins)

;; Start emacs server when in windows system:
(when window-system (server-start))

;; Set font according to os:
(cond
 ((equal system-type 'darwin)
  (set-face-attribute 'default nil :family "Monaco" :height 130 :weight 'normal))
 ((and nil (equal system-type 'gnu/linux))
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 180 :weight 'normal)))

;; Disable truncating lines when viewing diffs:
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

;; prevent exit prompt
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
        "Prevent annoying \"Active processes exist\" query when you quit Emacs."
        (flet ((process-list ())) ad-do-it))

;; Display pluging load errors:
(if (> (list-length plugin-error-list) 0)
    (error "Plugin Errors %s" plugin-error-list))
