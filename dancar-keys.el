;; (l) dancar
;;;

;; Reminder: (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "<f4>") (lambda () (interactive) (dired "~/dev")))
(global-set-key (kbd "<f5>") (lambda () (interactive) (dired "~/dev/devmachines")))

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x d") `dancar-dired)
(global-set-key (kbd "C-x C-d") `dancar-dired)
(global-set-key (kbd "C-x D") `dired)

(global-set-key (kbd "C-<f7>") 'coffee-compile-region)
(global-set-key (kbd "C-c n") 'new-snippet)


;; MBP Adaptation:

(global-set-key [C-s-268632076] (lambda () (interactive) (indent-selection 2)))
(global-set-key [C-s-268632072] (lambda () (interactive) (indent-selection -2)))

(fset 'init_kbd_fn
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 111 134217788 19 99 111 109 109 97 110 100 13 6 67108896 19 44 2 24 114 115 49 24 111 24 114 105 49 40 103 108 111 98 97 108 45 115 101 116 45 107 101 121 32 40 107 98 100 32 34 115 45 34 41 32 39 5 41 18 34 13] 0 "%d")) arg)))
(global-set-key (kbd "<f10>") 'init_kbd_fn)


(global-set-key (kbd "C-c t") 'twittering-update-status-interactive)

(define-key helm-map (kbd "C-|") `dancar-helm-switch-to-full)

(global-set-key (kbd "s-z") 'zap-to-char)
(global-set-key (kbd "s-}") 'forward-paragraph)
(global-set-key (kbd "s-{") 'backward-paragraph)
(global-set-key (kbd "s-m") 'back-to-indentation)
(global-set-key (kbd "") 'back-to-indentation)
(global-set-key (kbd "s-r") 'move-to-window-line-top-bottom)
(global-set-key (kbd "s-v") 'scroll-down-command)
(global-set-key (kbd "s-d") 'subword-kill)
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
(global-set-key (kbd "s-c") 'subword-capitalize)
(global-set-key (kbd "s-l") 'subword-downcase)
(global-set-key (kbd "s-u") 'subword-upcase)
(global-set-key (kbd "s-%") 'query-replace)
(global-set-key (kbd "s-<backspace>") 'subword-backward-kill)
(global-set-key (kbd "s-g") goto-map)
(global-set-key (kbd "s-z") 'zap-to-char)
(global-set-key (kbd "s-s") search-map)
(global-set-key (kbd "s-s a") 'ag-project-at-point)
(global-set-key (kbd "s-;") 'comment-line-toggle)
(global-set-key (kbd "s-:") 'eval-expression)
(global-set-key (kbd "s-!") 'shell-command)
;; Digits:
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

(global-set-key (kbd "s-g s-n") 'next-error)
(global-set-key (kbd "s-g s-p") 'previous-error)

(global-set-key (kbd "s-g s-g") 'goto-line)
(global-set-key (kbd "s-s r") 'rgrep)
(global-set-key (kbd "s-q") 'highlight-symbol-next)
(global-set-key (kbd "s-Q") 'highlight-symbol-prev)
(global-set-key (kbd "C-c C-h") `highlight-symbol-at-point)


;; (global-set-key (kbd "C-c C-=") 'sr-speedbar-toggle)
(global-set-key (kbd "C-x C-o") 'other-window)

(global-set-key (kbd "C-s-S-Y") 'browse-kill-ring)

(global-set-key (kbd "C-s-y") 'paste-from-register-1)
(global-set-key (kbd "C-s-W") 'copy-to-register-1)

(global-set-key [C-s-268632083] 'mc/edit-lines)
(global-set-key (kbd "C-w") 'dancar-kill)
(global-set-key (kbd "C-s-|") (lambda () (interactive) (deft) (deft-filter-clear)))

(global-set-key (kbd "C-c C-b") `bookmark-here-set)
(global-set-key (kbd "C-c C-j") `bookmark-here-jump)
(global-set-key (kbd "C-c b") `bookmark-here-set)
(global-set-key (kbd "C-c j") `bookmark-here-jump)

(global-set-key (kbd "s-P") `delete-indentation)
(global-set-key (kbd "s-N") (lambda() (interactive (delete-indentation 1))))
(global-set-key (kbd "C-c C-k") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-c k") (lambda () (interactive) (kill-buffer (current-buffer)) (delete-window)))
(global-set-key (kbd "C-c C-p") 'f3)
(global-set-key (kbd "<f8>") 'f3-switch-project)
(global-set-key (kbd "s-n") `move-text-down)
(global-set-key (kbd "s-p") `move-text-up)
(global-set-key (kbd "s-<return>") `kmacro-end-and-call-macro)
(global-set-key (kbd "C-S-s-<delete>") `erase-buffer)
(global-set-key (kbd "C-S-s-<kp-delete>") `erase-buffer)
(global-set-key (kbd "C-<kp-delete>") `delete-region)
(global-set-key (kbd "C-c C-g") `magit-status)
(global-set-key (kbd "C-#") `shell)
(global-set-key (kbd "S-<f3>") `highlight-symbol-next)
(global-set-key (kbd "s-S-<f3>") `highlight-symbol-prev)
(global-set-key (kbd "C-<f3>") `highlight-symbol-at-point)
(global-set-key (kbd "<home>") `move-beginning-of-line)
(global-set-key (kbd "<end>") `move-end-of-line)
(global-set-key (kbd "C-\\") `helm-dan-buffers)
(global-set-key (kbd "C-|") `helm-dan)
(global-set-key (kbd "C-;") `toggle-buffer)


(global-set-key (kbd "C-<return>") `go-line)
(global-set-key (kbd "s-k") (lambda () (interactive) (back-to-indentation) (kill-line)))
(global-set-key (kbd "C-S-k") `kill-whole-line)
(global-set-key (kbd "<f6>") `toggle-truncate-lines)
(global-set-key (kbd "s-]") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "s-[") (lambda () (interactive) (scroll-down-line 2)))
(global-set-key (kbd "C-s-[") (lambda () (interactive) (scroll-down-line 6)))
(global-set-key (kbd "C-s-]") (lambda () (interactive) (scroll-up-line 6)))
(global-set-key (kbd "C-s-f") (lambda () (interactive) (forward-char) (search-forward " ") (backward-char)))
(global-set-key (kbd "C-s-b") (lambda () (interactive) (backward-char) (search-backward " ") (backward-char)))
(global-set-key (kbd "C-S-<SPC>") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-?") 'undo-tree-redo)
(global-set-key  (kbd "C-<tab>") `other-window)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)

(global-set-key  [C-s-268632080] (lambda () (interactive) (previous-line 4)))
(global-set-key  [C-s-268632078] (lambda () (interactive) (next-line 4)))
(global-set-key  (kbd "C-s-S-p") (lambda () (interactive) (previous-line 12)))
(global-set-key  (kbd "C-s-S-n") (lambda () (interactive) (next-line 12)))

;; ruby-mode keys override:
(defvar my-ruby-mode-keys-minor-mode-map (make-keymap) "my-ruby-mode-keys-minor-mode keymap.")
(define-key my-ruby-mode-keys-minor-mode-map (kbd "<RET>") 'newline-and-indent)

(define-minor-mode my-ruby-mode-keys-minor-mode
  "A minor mode so fix ruby-mode keys"
  nil " my-ruby-mode-keys" 'my-ruby-mode-keys-minor-mode-map)
(add-hook 'ruby-mode-hook 'my-ruby-mode-keys-minor-mode)
(add-hook 'ruby-mode-hook 'my-super-mode-keys-minor-mode) ;;TODO: recheck
;; /

;; emacs-lisp-mode keys override:
(defvar my-emacs-lisp-mode-keys-minor-mode-map (make-keymap) "my-emacs-lisp-mode-keys-minor-mode keymap.")
(define-key my-emacs-lisp-mode-keys-minor-mode-map (kbd "<RET>") 'newline-and-indent)

(define-minor-mode my-emacs-lisp-mode-keys-minor-mode
  "A minor mode so fix emacs-lisp-mode keys"
  nil " my-emacs-lisp-mode-keys" 'my-emacs-lisp-mode-keys-minor-mode-map)
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-keys-minor-mode)
;; /



;; org-mode keys-override:
(defvar my-org-mode-keys-minor-mode-map (make-keymap) "my-org-mode-keys-minor-mode keymap.")

(define-key my-org-mode-keys-minor-mode-map (kbd "C-<tab>") `other-window)
(define-key my-org-mode-keys-minor-mode-map (kbd "C-c C-p") 'f3)
(define-key my-org-mode-keys-minor-mode-map (kbd "C-c C-k") 'kill-buffer-and-window)
(define-minor-mode my-org-mode-keys-minor-mode
  "A minor mode so fix org-mode keys"
  nil " my-org-mode-keys" 'my-org-mode-keys-minor-mode-map)
(add-hook 'org-mode-hook 'my-org-mode-keys-minor-mode)
;; /


;;; super keys
(defvar my-super-mode-keys-minor-mode-map (make-keymap) "my-super-mode-keys-minor-mode keymap.")

(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-p") (lambda () (interactive) (previous-line 4)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-n") (lambda () (interactive) (next-line 4)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-S-p") (lambda () (interactive) (previous-line 10)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-S-n") (lambda () (interactive) (next-line 10)))

(define-minor-mode my-super-mode-keys-minor-mode
  "A minor mode so fix super-mode keys"
  nil " DanSuperKeys" 'my-super-mode-keys-minor-mode-map)
(my-super-mode-keys-minor-mode 1)
(defadvice load (after give-my-super-mode-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-super-mode-keys-minor-mode))
      (let ((mykeys (assq 'my-super-mode-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-super-mode-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)
;; /

;; scss-mode keys-override:
(defvar my-scss-mode-keys-minor-mode-map (make-keymap) "my-scss-mode-keys-minor-mode keymap.")

(define-key my-scss-mode-keys-minor-mode-map (kbd "<RET>") `newline-and-indent)

(define-minor-mode my-scss-mode-keys-minor-mode
  "A minor mode so fix scss-mode keys"
  nil " my-scss-mode-keys" 'my-scss-mode-keys-minor-mode-map)
(add-hook 'scss-mode-hook 'my-scss-mode-keys-minor-mode)
;; /

;; Set newline
(defun set-newline-and-indent ()
  (interactive)
  (local-set-key (kbd "RET") 'newline-and-indent))
;;/

(provide 'dancar-keys)
