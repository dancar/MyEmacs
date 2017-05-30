(global-set-key (kbd "C-j") 'dancar-jump-line-next-small)
(global-set-key (kbd "C-k") 'dancar-jump-line-previous-small)
(global-set-key [C-s-268632074] 'dancar-jump-line-next-medium)
(global-set-key [C-s-268632075] 'dancar-jump-line-previous-medium)
(global-set-key (kbd "C-S-s-j") 'dancar-jump-line-next-big)
(global-set-key (kbd "C-S-s-k") 'dancar-jump-line-previous-big)
(global-set-key (kbd "C-e") 'move-end-of-line)
(define-key evil-motion-state-map (kbd "C-e") 'move-end-of-line)

;; ctrl-g fix
(key-chord-define-global
 "`1"
 (lambda ()
   (interactive)
   (evil-normal-state)
   (save-buffer)))

(use-package evil-mc
  :config
  (defun dancar-toggle-evil-mc-mode ()
    (interactive)
    (if evil-mc-mode
        (progn
          (evil-mc-undo-all-cursors)
          (evil-mc-mode 0)
          (message "evil-mc-mode is ON")
          )
      (progn
        (evil-mc-mode 1)
        (message "evil-mc-mode is OFF")
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

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (keyboard-quit))

;; (define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-motion-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-insert-state-map   (kbd "C-g") #'evil-keyboard-quit)
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
