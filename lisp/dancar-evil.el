(require 'evil)
;; ctrl-g fix
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
  (message "HERE")
  )

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)
  )

(evil-mode 1)
(provide 'dancar-evil)
;;;;;;;;;;;;;;;;;;
