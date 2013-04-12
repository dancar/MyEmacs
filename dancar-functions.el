(defun comment-line-toggle ()
  "Toggle current line or region's commenting
  (c) dancar"
  (interactive)
  (comment-normalize-vars)
  (if (and mark-active transient-mark-mode)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))
(global-set-key (kbd "M-;") 'comment-line-toggle)


(defun go-line ()
  (interactive)
  (search-backward " ")
  (delete-char 1)
  (newline-and-indent)
  (previous-line)
  (end-of-line)
    (if (equal major-mode `coffee-mode)
      (coffee-newline-and-indent)
      (newline-and-indent)))


(defun server-tail()
  (interactive)
  (shell "server")
  (insert "tail -f ~/dev/tma/log/development.log")
  (comint-send-input))

(defun console()
  (interactive)
  (shell "console")
  (insert "rails c")
  (comint-send-input)
  (other-buffer))

(defun seed()
  (interactive)
  (shell-action "rake db:seed"))

(defun compass()
  (interactive)
  (shell-action "tma_compass"))

(global-set-key (kbd "<f10>") 'seed)
(global-set-key (kbd "<f11>") `compass)

(defun same-issue ()
  "Copies issue number to commit message (c) dancar"
  (interactive)
  (beginning-of-buffer)
  (next-line)
  (end-of-line)
  (search-backward "(")
  (copy-to-register `x (point) (line-end-position))
  (magit-log-edit)
  (insert " ")
  (insert-register `x)
  (beginning-of-buffer)
  )

;; shell-action-init:
;; ((lambda ()
;;   (setq shell-actions-buffer "shell-actions")
;;   (shell shell-actions-buffer)
;;   (switch-to-buffer nil)
;;   ))


(defun shell-action (action)
  (shell-action-base action 1))

(defun shell-action-base (action wait)
  (interactive)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer shell-actions-buffer)
  (insert action)
  (comint-send-input)
  (if wait
      (let ((cursor-in-echo-area 1))
        (read-event "Press any key to continue")))
  (delete-window))

(defun shell-action-bg (action)
  (shell-action-base action nil))

(defun tail (file)
  (interactive "fFile name:")
  (shell (concat (file-name-nondirectory file) "-tail"))
  (insert (concat "tail -f " file))
  (comint-send-input))

(defun bookmark-here-set ()
  (interactive)
  (bookmark-set "_hereBookmark")
  (message "Bookmark set"))

(defun bookmark-here-jump ()
  (interactive)
  (bookmark-jump "_hereBookmark"))

(defun goto-notes ()
  "Open the \"notes\" bookmark"
  (interactive)
  (bookmark-bmenu-list) ;; Mysterious bug causes the bookmark not to be found unless ths list is preloaded
  (kill-buffer "*Bookmark List*")
  (let ((notes-buffer (get-buffer "notes.txt")))
    (if notes-buffer
        (switch-to-buffer notes-buffer)
      (bookmark-jump "notes"))))

(fset 'little-coffee-window
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 49 24 50 C-tab 21 21 134217848 115 104 114 105 tab return C-tab] 0 "%d")) arg)))

(provide 'dancar-functions)
