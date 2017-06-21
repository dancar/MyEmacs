;; (l) dancar
(setq macright-command-modifier 'hyper)

;; COOL STUFF
(global-set-key (kbd "C-c n") 'new-snippet)
;; (define-key helm-map (kbd "C-|") `dancar-helm-switch-to-full)
(global-set-key (kbd "C-s-|") (lambda () (interactive) (deft) (deft-filter-clear)))
(global-set-key (kbd "C-\\") `helm-dan)
(global-set-key (kbd "C-<return>") `go-line)
(global-set-key (kbd "C-S-s-y") 'helm-show-kill-ring)
(global-set-key (kbd "s-O") (lambda () (interactive) (evil-open-above 1) (evil-normal-state) (evil-next-line)))
(global-set-key (kbd "s-o") (lambda () (interactive) (evil-open-below 1) (evil-normal-state) (evil-previous-line)))
(global-set-key (kbd "s-<backspace>") 'dancar-concentrate)

;; TEXT
(global-set-key (kbd "s-k") 'kill-whole-line)
(global-set-key (kbd "s-;") 'comment-line-toggle)
(global-set-key (kbd "s-P") `delete-indentation)
(global-set-key (kbd "s-N") (lambda() (interactive (delete-indentation 1))))
(global-set-key [C-s-right] (lambda () (interactive) (indent-selection 2)))
(global-set-key [C-s-left] (lambda () (interactive) (indent-selection -2)))

;; WINDOWS
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "C-;") `toggle-buffer)
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "<backtab>") 'other-window)
(global-set-key  (kbd "C-<tab>") `other-window)
(global-set-key (kbd "C-x <backtab>") (lambda () (interactive) (rotate-windows -1) (other-window 1)))
(global-set-key (kbd "C-x C-<tab>") (lambda () (interactive) (rotate-windows -1) (other-window 1)))


;; MOTION
(global-set-key (kbd "s-m") 'back-to-indentation)
(global-set-key (kbd "C-c b") 'bookmark-here-set)
(global-set-key (kbd "C-c j") 'bookmark-here-jump)
;;(global-set-key (kbd "s-g s-n") 'next-error)
;;(global-set-key (kbd "s-g s-p") 'previous-error)
(global-set-key (kbd "s-]") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "s-[") (lambda () (interactive) (scroll-down-line 2)))
(global-set-key  [C-s-268632080] 'dancar-jump-line-previous-small)
(global-set-key  [C-s-268632078] 'dancar-jump-line-next-small)
(global-set-key  (kbd "C-s-S-p") (lambda () (interactive) (previous-line 12)))
(global-set-key  (kbd "C-s-S-n") (lambda () (interactive) (next-line 12)))


;; MISC SHORTCUTS
(global-set-key (kbd "<f12>") 'package-list-packages)
(global-set-key (kbd "C-x d") `dancar-dired)
(global-set-key (kbd "C-x c-d") `dancar-dired)
(global-set-key (kbd "<f4>") (lambda () (interactive) (dired "~/dev")))
(global-set-key (kbd "C-c N") (lambda() (interactive) (dired "~/Dropbox/snippets")))
(global-set-key (kbd "C-c p") (lambda () (interactive) (save-buffer) (kill-ring-save (point-min) (point-max)) (message "Buffer copied.")))
(global-set-key [C-s-268632087] (lambda () (interactive (kill-buffer (current-buffer)))))
(global-set-key (kbd "s-q") 'highlight-symbol-next)
(global-set-key (kbd "s-Q") 'highlight-symbol-prev)
(global-set-key (kbd "C-c C-h") `highlight-symbol-at-point)
(global-set-key (kbd "C-c H") `highlight-symbol-remove-all)
(global-set-key (kbd "s-<return>") `kmacro-end-and-call-macro)
(global-set-key (kbd "C-c C-g") (lambda () (interactive) (magit-status) (delete-other-windows)))
(global-set-key (kbd "C-#") `shell)
(global-set-key (kbd "<f6>") `toggle-truncate-lines)


;;;MBP
;;(global-set-key (kbd "s-g s-g") 'goto-line)
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
(global-set-key [C-s-268632095] 'negative-argument)
(global-set-key [C-s-268632086] 'scroll-other-window)
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
