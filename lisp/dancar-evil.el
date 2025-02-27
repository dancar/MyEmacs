(add-hook 'git-commit-mode-hook 'evil-insert-state)

(global-set-key (kbd "<mouse-3>") 'evil-force-normal-state)

(key-chord-define-global
 "nj"
 (lambda ()
   (interactive)
   ;; (save-buffer)
   (evil-normal-state 1)
   ))

(key-chord-define-global
 "`1"
 (lambda ()
   (interactive)
   (evil-normal-state 1)
   (save-buffer)
   ))

(key-chord-define-global
 "~!"
 (lambda ()
   (interactive)
   (evil-normal-state 1)
   (save-some-buffers)
   ))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))


(use-package evil-mc
  :config
  (defun dancar-toggle-evil-mc-mode ()
    (interactive)
    (if evil-mc-mode
        (progn
          (evil-mc-undo-all-cursors)
          (evil-mc-mode 0)
          (message "evil-mc-mode is OFF")
          )
      (progn
        (evil-mc-mode 1)
        (message "evil-mc-mode is ON")
        )
      ))
  :chords (
           ("mc" . dancar-toggle-evil-mc-mode)
           ))


;; (Stolen from: https://emacs.stackexchange.com/questions/13763/how-can-i-make-c-g-run-both-evil-force-normal-state-and-keyboard-quit )
(defun quit-it ()
  "If in evil insert state, force normal state, else run
            `keyboard-quit'."
  (interactive)
  (if (and evil-mode (eq evil-state 'insert))
      (evil-force-normal-state)
    (keyboard-quit)))

(defun dancar-quit-mc-mode ()
   (if evil-mc-mode
      (progn
        (evil-mc-undo-all-cursors)
        (evil-mc-mode 0)
        )))

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (dancar-quit-mc-mode)
  (keyboard-quit)
  (keyboard-quit))

;; (define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-motion-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-insert-state-map   (kbd "C-g") (lambda() (interactive )(evil-normal-state 1) (dancar-quit-mc-mode) ) )
(define-key evil-window-map         (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-operator-state-map (kbd "C-g") #'evil-keyboard-quit)


(use-package evil-magit)
(use-package evil-org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (evil-org-set-key-theme '(navigation insert textobjects additional))
  )

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)
  )

(provide 'dancar-evil)
;;;;;;;;;;;;;;;;;;
