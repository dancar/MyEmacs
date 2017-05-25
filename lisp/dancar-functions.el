;;; original and stolen functions


;;; stolen from: https://www.emacswiki.org/emacs/InsertingTodaysDate
(defun date (arg)
   (interactive "P")
   (insert (if arg
               (format-time-string "%d.%m.%Y")
             (format-time-string "%Y-%m-%d"))))

(defun dancar-helm-switch-to-full ()
  (interactive)
  (setq dan-temp-query (minibuffer-contents))
  (helm-exit-and-execute-action
   (lambda(ignore)
     (helm-dan `,dan-temp-query))))

(defun helm-dan (&optional input)
  (interactive)
  (helm :sources '(
                   helm-source-buffers-list
                   helm-source-ls-git-status
                   helm-source-bookmarks
                   helm-source-recentf
                   helm-source-ls-git
                   helm-source-buffer-not-found
                   )
        :buffer "*helm dan*"
        :input input))

(defun helm-dan-buffers ()
 (interactive)
 (helm-buffers-list))
 ;; (require 'helm-files)
 ;; (helm-other-buffer
 ;;  '(helm-source-buffers-list)
 ;;  "*helm dan buffers*"))

(defun date ()
  (interactive)
  (insert (shell-command-to-string "date")))

;; stolen: http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun toggle-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

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
  (beginning-of-buffer))

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
  (bookmark-bmenu-list) ;; Mysterious bug causes the bookmark not to be found unless the list is preloaded
  (kill-buffer "*Bookmark List*")
  (let ((notes-buffer (get-buffer "notes.txt")))
    (if notes-buffer
        (switch-to-buffer notes-buffer)
      (bookmark-jump "notes"))))

(fset 'little-coffee-window
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 49 24 50 C-tab 21 21 134217848 115 104 114 105 tab return C-tab] 0 "%d")) arg)))


(defun dancar-kill ()
  "Kill the region if active, else backward-kill subword"
  (interactive)
  (if
      (region-active-p)
      (kill-region (region-beginning) (region-end))
    (subword-backward-kill 1)))


;; Stolen from http://irreal.org/blog/?p=354
(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

(defun new-buffer ()
  "Creates new buffers with iterative names
  (l) dancar"
  (interactive)
  (let*
      ((i 0)
       (name (buffer-name (current-buffer)))
       )

    (while (get-buffer name)
      (set `i (+ i 1))
      (set `name
           (concat "new-" (number-to-string i)))
    (switch-to-buffer name)
    )
  ))

(setq snippets-dir "~/Dropbox/snippets/")
(defun new-snippet ()
  (interactive)
  (let* (
         (filter-regexp "[0-9][0-9][0-9][0-9]")
         (files (directory-files snippets-dir nil filter-regexp))
         (get-number (lambda (filename)
                       (string-to-number (substring filename 0 4))))
         (numbers (mapcar get-number files))
         (new-number (+ 1 (apply 'max (cons 0 numbers))))
         (new-filename (format "%04d" new-number))
         (new-full-filename (concat snippets-dir new-filename))
         )
    (find-file new-full-filename)))


(defun indent-selection (count)
  (interactive)
  (let (
        (deactivate-mark)
        (start (if (use-region-p)
                   (region-beginning)
                 (line-beginning-position)))
        (end (if (use-region-p)
                 (region-end)
               (line-end-position)))
        )
    (indent-rigidly start end count)))

(defun dancar-dired ()
  (interactive)
  (if (buffer-file-name)
      (dired (file-name-directory (buffer-file-name)))
    (execute-extended-command nil "dired")))

(defun view-functions ()
  (interactive)
  (let ((rx
        (case major-mode
          (`js-mode "^  [a-zA-Z]+:")
          (`coffee-mode "^  [a-zA-Z]+:")
          (`yaml-mode "^  [a-zA-Z]+:")
          ('enh-ruby-mode "^[ ]*def [a-zA-Z_]+"))))
    (occur rx)))
(global-set-key (kbd "C-c f") `view-functions)

(provide 'dancar-functions)
