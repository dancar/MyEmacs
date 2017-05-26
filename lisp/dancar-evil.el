(require 'evil)
(use-package key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'evil-normal-state)
  )

(use-package evil-magit)
(evil-mode 1)
(provide 'dancar-evil)
;;;;;;;;;;;;;;;;;;
