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

(defun dancar-kill ()
  "Kill the region if active, else backward-kill subword"
  (interactive)
  (if
      (region-active-p)
      (kill-region (region-beginning) (region-end))
    (subword-backward-kill 1)))

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

(setq dancar-small-jump 7)
(setq dancar-big-jump 12)
(defun dancar-jump-line-next-small()
  (interactive)
  (next-line dancar-small-jump))

(defun dancar-jump-line-previous-small()
  (interactive)
  (previous-line dancar-small-jump))

(defun dancar-jump-line-next-big()
  (interactive)
  (next-line dancar-big-jump))

(defun dancar-jump-line-previous-big()
  (interactive)
  (previous-line dancar-big-jump))

(provide 'dancar-functions)
