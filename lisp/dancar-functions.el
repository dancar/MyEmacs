;;; original and stolen functions

(defun dancar-round-paren ()
  (interactive)
  (insert "()")
  (left-char)
  )

(defun dancar-curly-paren ()
  (interactive)
  (insert "{}")
  (left-char)
  )


(defun dancar-square-paren ()
  (interactive)
  (insert "[]")
  (left-char)
  )

(defun dancar-concentrate ()
   (interactive)
   (delete-other-windows)
   (neotree-hide)
   (back-to-indentation)
   (toggle-frame-maximized))


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
;(helm-buffers-list--init)
(defun helm-dan (&optional input)
  (interactive)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
  (helm :sources '(
                   helm-source-buffers-list
                   helm-source-projectile-files-list
                   helm-source-bookmarks
                   helm-source-recentf
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

(defun dancar-dired ()
  (interactive)
  (if (buffer-file-name)
      (dired (file-name-directory (buffer-file-name)))
    (execute-extended-command nil "dired")))

(setq dancar-small-jump 3)
(setq dancar-medium-jump 6)
(setq dancar-big-jump 14)

(defun dancar-jump-line-next-small()
  (interactive)
  (next-line dancar-small-jump))

(defun dancar-jump-line-previous-small()
  (interactive)
  (previous-line dancar-small-jump))

(defun dancar-jump-line-next-medium()
  (interactive)
  (next-line dancar-medium-jump))

(defun dancar-jump-line-previous-medium()
  (interactive)
  (previous-line dancar-medium-jump))

(defun dancar-jump-line-next-big()
  (interactive)
  (next-line dancar-big-jump))

(defun dancar-jump-line-previous-big()
  (interactive)
  (previous-line dancar-big-jump))

(defun rotate-windows (arg)
  "Rotate your windows; use the prefix argument to rotate the other direction"
  (interactive "P")
  (if (not (> (count-windows) 1))
      (message "You can't rotate a single window!")
    (let* ((rotate-times (prefix-numeric-value arg))
           (direction (if (or (< rotate-times 0) (equal arg '(4)))
                          'reverse 'identity)))
      (dotimes (_ (abs rotate-times))
        (dotimes (i (- (count-windows) 1))
          (let* ((w1 (elt (funcall direction (window-list)) i))
                 (w2 (elt (funcall direction (window-list)) (+ i 1)))
                 (b1 (window-buffer w1))
                 (b2 (window-buffer w2))
                 (s1 (window-start w1))
                 (s2 (window-start w2))
                 (p1 (window-point w1))
                 (p2 (window-point w2)))
            (set-window-buffer-start-and-point w1 b2 s2 p2)
            (set-window-buffer-start-and-point w2 b1 s1 p1)))))))

(provide 'dancar-functions)
