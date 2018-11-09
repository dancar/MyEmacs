;; (l) dancar
;;; Code:
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-command-modifier 'meta)
  )


;; H-Y-P-E-R
(setq mac-right-command-modifier 'hyper)
(global-set-key (kbd "H-<backspace>") 'dancar-notebook-buffer)

(global-set-key (kbd "H-t") `toggle-truncate-lines)
(global-set-key (kbd "H-f") 'projectile-find-file)
(global-set-key (kbd "H-s") 'projectile-ripgrep)
(global-set-key (kbd "H-g") (lambda () (interactive) (magit-status) (delete-other-windows)))
(global-set-key (kbd "C-M-S-<return>") 'evil-org-org-insert-heading-respect-content-below)
(global-set-key (kbd "H-=") 'text-scale-increase)
(global-set-key (kbd "H--") 'text-scale-decrease)


;; (global-set-key (kbd "H-s") (lambda () (interactive) (insert "ß")))
;; (global-set-key (kbd "H-u") (lambda () (interactive) (insert "ü")))
;; (global-set-key (kbd "H-o") (lambda () (interactive) (insert "ö")))
;; (global-set-key (kbd "H-a") (lambda () (interactive) (insert "ä")))

;; (global-set-key (kbd "H-S") (lambda () (interactive) (insert "ß")))
;; (global-set-key (kbd "H-U") (lambda () (interactive) (insert "Ü")))
;; (global-set-key (kbd "H-O") (lambda () (interactive) (insert "Ö")))
;; (global-set-key (kbd "H-A") (lambda () (interactive) (insert "Ä")))

(global-set-key (kbd "H-a") (lambda () (interactive) (bookmark-jump "a")))
(global-set-key (kbd "H-b") (lambda () (interactive) (bookmark-jump "b")))
(global-set-key (kbd "H-c") (lambda () (interactive) (bookmark-jump "c")))
(global-set-key (kbd "H-0") (lambda () (interactive) (bookmark-jump "0")))
(global-set-key (kbd "H-1") (lambda () (interactive) (bookmark-jump "1")))
(global-set-key (kbd "H-2") (lambda () (interactive) (bookmark-jump "2")))
(global-set-key (kbd "H-3") (lambda () (interactive) (bookmark-jump "3")))
(global-set-key (kbd "H-4") (lambda () (interactive) (bookmark-jump "4")))
(global-set-key (kbd "H-5") (lambda () (interactive) (bookmark-jump "5")))
(global-set-key (kbd "H-6") (lambda () (interactive) (bookmark-jump "6")))
(global-set-key (kbd "H-7") (lambda () (interactive) (bookmark-jump "7")))
(global-set-key (kbd "H-8") (lambda () (interactive) (bookmark-jump "8")))
(global-set-key (kbd "H-9") (lambda () (interactive) (bookmark-jump "9")))

(global-set-key (kbd "C-x H-a") (lambda () (interactive) (bookmark-set "a")))
(global-set-key (kbd "C-x H-b") (lambda () (interactive) (bookmark-set "b")))
(global-set-key (kbd "C-x H-c") (lambda () (interactive) (bookmark-set "c")))
(global-set-key (kbd "C-x H-0") (lambda () (interactive) (bookmark-set "0")))
(global-set-key (kbd "C-x H-1") (lambda () (interactive) (bookmark-set "1")))
(global-set-key (kbd "C-x H-2") (lambda () (interactive) (bookmark-set "2")))
(global-set-key (kbd "C-x H-3") (lambda () (interactive) (bookmark-set "3")))
(global-set-key (kbd "C-x H-4") (lambda () (interactive) (bookmark-set "4")))
(global-set-key (kbd "C-x H-5") (lambda () (interactive) (bookmark-set "5")))
(global-set-key (kbd "C-x H-6") (lambda () (interactive) (bookmark-set "6")))
(global-set-key (kbd "C-x H-7") (lambda () (interactive) (bookmark-set "7")))
(global-set-key (kbd "C-x H-8") (lambda () (interactive) (bookmark-set "8")))
(global-set-key (kbd "C-x H-9") (lambda () (interactive) (bookmark-set "9")))


;; COOL STUFF
(global-set-key (kbd "C-c V") 'dancar-open-in-vscode)
(global-set-key (kbd "M-s o") 'helm-swoop)
(global-set-key (kbd "C-x C-b") (lambda () (interactive) (list-buffers) (other-window 1) (delete-other-windows)))
(global-set-key (kbd "C-c n") 'new-snippet)
(global-set-key (kbd "C-\\") `helm-dan)
(global-set-key (kbd "C-<return>") `dancar-go-line)
(global-set-key (kbd "C-M-Y") 'helm-show-kill-ring)
(global-set-key (kbd "M-O") (lambda () (interactive) (evil-open-above 1) (evil-normal-state) (evil-next-line)))
(global-set-key (kbd "M-o") (lambda () (interactive) (evil-open-below 1) (evil-normal-state) (evil-previous-line)))
(global-set-key (kbd "M-<backspace>") 'dancar-concentrate)
(global-set-key (kbd "C-c F") (lambda () (interactive) (kill-new buffer-file-truename) (message (concat "Copied: " buffer-file-truename))))
(global-set-key (kbd "C-c C-F") 'dancar-copy-file-and-line)

;; TEXT
(define-key evil-insert-state-map (kbd "C-d") nil)
(global-set-key (kbd "M-k") 'kill-whole-line)
(global-set-key (kbd "M-;") 'comment-line-toggle)
(global-set-key (kbd "M-P") `delete-indentation)
(global-set-key (kbd "M-N") (lambda() (interactive (delete-indentation 1))))
(global-set-key [C-M-right] (lambda () (interactive) (indent-selection 2)))
(global-set-key [C-M-left] (lambda () (interactive) (indent-selection -2)))

;; WINDOWS / BUFFERS
;; (global-set-key (kbd "C-M-w") (lambda () (interactive) (kill-buffer (current-buffer))(delete-window)))
(global-set-key (kbd "C-M-w") (lambda () (interactive) (kill-buffer (current-buffer))))

(global-set-key (kbd "C-;") `toggle-buffer)
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "<backtab>") 'ace-window)
(global-set-key (kbd "C-x <backtab>") (lambda () (interactive) (rotate-windows -1) (other-window 1)))
(global-set-key (kbd "C-x C-<tab>") (lambda () (interactive) (rotate-windows -1) (other-window 1)))
(global-set-key (kbd "M-}") 'tabbar-forward-tab)

(define-key org-mode-map "\M-}" nil)
(define-key org-mode-map "\M-{" nil)

;; MOTION
(global-set-key (kbd "M-m") 'back-to-indentation)
(global-set-key (kbd "C-c b") 'bookmark-here-set)
(global-set-key (kbd "C-c j") 'bookmark-here-jump)
(global-set-key (kbd "M-]") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "M-[") (lambda () (interactive) (scroll-down-line 2)))
(define-key evil-motion-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-motion-state-map (kbd "C-S-a") 'evil-first-non-blank)
(define-key evil-insert-state-map (kbd "C-S-a") 'evil-first-non-blank)

;; line jumps:
;; hjkl:
(define-key evil-insert-state-map (kbd "C-j") 'dancar-jump-line-next-small)
(define-key evil-insert-state-map (kbd "C-M-j") 'dancar-jump-line-next-medium)
(define-key evil-insert-state-map (kbd "C-S-M-j") 'dancar-jump-line-next-big)

(define-key evil-insert-state-map (kbd "C-k") 'dancar-jump-line-previous-small)
(define-key evil-insert-state-map (kbd "C-M-k") 'dancar-jump-line-previous-medium)
(define-key evil-insert-state-map (kbd "C-S-M-k") 'dancar-jump-line-previous-big)

(define-key evil-motion-state-map (kbd "C-j") 'dancar-jump-line-next-small)
(define-key evil-motion-state-map (kbd "C-M-j") 'dancar-jump-line-next-medium)
(define-key evil-motion-state-map (kbd "C-S-M-j") 'dancar-jump-line-next-big)

(define-key evil-motion-state-map (kbd "C-k") 'dancar-jump-line-previous-small)
(define-key evil-motion-state-map (kbd "C-M-k") 'dancar-jump-line-previous-medium)
(define-key evil-motion-state-map (kbd "C-S-M-k") 'dancar-jump-line-previous-big)

;; n/p:
(define-key evil-insert-state-map (kbd "C-p") 'previous-line )
(global-set-key  (kbd "C-M-p") 'dancar-jump-line-previous-small)
(global-set-key  (kbd "C-M-S-p") 'dancar-jump-line-previous-big)

(define-key evil-insert-state-map (kbd "C-n") 'next-line )
(global-set-key  (kbd "C-M-n") 'dancar-jump-line-next-small)
(global-set-key  (kbd "C-M-S-n") 'dancar-jump-line-next-big)

;; MISC COPING WITH EVIL:
(define-key evil-insert-state-map (kbd "M-v") 'evil-paste-after)
(define-key evil-normal-state-map (kbd "M-v") 'evil-paste-after)
(define-key evil-normal-state-map (kbd "C-t") (lambda () (interactive) (transpose-chars 1)))
(define-key evil-insert-state-map (kbd "C-t") 'transpose-chars)

;; MISC SHORTCUTS

(global-set-key (kbd "C-|") 'helm-ls-git-ls)
(global-set-key (kbd "<f12>") 'paradox-list-packages)
(global-set-key (kbd "C-x d") `dired-jump)
(global-set-key (kbd "<f4>") (lambda () (interactive) (dired "~/dev")))
(global-set-key (kbd "C-c N") (lambda() (interactive) (dired "~/Dropbox/snippets")))
(global-set-key (kbd "C-x p") 'dancar-copy-buffer)
(global-set-key (kbd "M-q") 'highlight-symbol-next)
(global-set-key (kbd "M-Q") 'highlight-symbol-prev)
(global-set-key (kbd "C-c C-h") `highlight-symbol-at-point)
(global-set-key (kbd "C-c H") `highlight-symbol-remove-all)
(global-set-key (kbd "M-<return>") `kmacro-end-and-call-macro)
(global-set-key (kbd "C-#") `shell)
(global-set-key (kbd "<f6>") `toggle-truncate-lines)
(global-set-key (kbd "C-M-|") 'deft)


;;;MBP
(global-set-key (kbd "s-0") 'digit-argument)
(global-set-key (kbd "s-1") 'digit-argument)
(global-set-key (kbd "s-2") 'digit-argument)
(global-set-key (kbd "s-3") 'digit-argument)
(global-set-key (kbd "s-4") 'digit-argument)
(global-set-key (kbd "s-5") 'digit-argument)
(global-set-key (kbd "s-6") 'digit-argument)
(global-set-key (kbd "s-7") 'digit-argument)
(global-set-key (kbd "s-8") 'digit-argument)
(global-set-key (kbd "s-9") 'digit-argument)
(global-set-key (kbd "s-w") 'kill-ring-save)
(global-set-key (kbd "s-f") 'subword-forward)
(global-set-key (kbd "s-b") 'subword-backward)
(global-set-key (kbd "s-x") 'execute-extended-command)
(global-set-key (kbd "s-t") 'transpose-words)
(global-set-key (kbd "s-y") 'yank-pop)
(global-set-key (kbd "s-<") 'beginning-of-buffer)
(global-set-key (kbd "s->") 'end-of-buffer)
(global-set-key (kbd "s-r") 'move-to-window-line-top-bottom)
(global-set-key (kbd "s-c") 'subword-capitalize)
(global-set-key (kbd "s-l") 'subword-downcase)
(global-set-key (kbd "s-u") 'subword-upcase)
(global-set-key (kbd "s-s") search-map)
(global-set-key (kbd "s-s a") 'ag-project-at-point)
(global-set-key (kbd "s-:") 'eval-expression)
(global-set-key (kbd "s-!") 'shell-command)
(global-set-key (kbd "s-s r") 'rgrep)


;; emacs-lisp-mode keys override:
(defvar my-emacs-lisp-mode-keys-minor-mode-map (make-keymap) "my-emacs-lisp-mode-keys-minor-mode keymap.")
(define-key my-emacs-lisp-mode-keys-minor-mode-map (kbd "<RET>") 'newline-and-indent)

(define-minor-mode my-emacs-lisp-mode-keys-minor-mode
  "A minor mode so fix emacs-lisp-mode keys"
  nil " my-emacs-lisp-mode-keys" 'my-emacs-lisp-mode-keys-minor-mode-map)
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-keys-minor-mode)
;; /

;; Set newline everywhereish
(defun set-newline-and-indent ()
  (interactive)
  (local-set-key (kbd "RET") 'newline-and-indent))
;;/
(add-hook 'prog-mode-hook 'set-newline-and-indent)

(provide 'dancar-keys)
