;; Code copied from: http://ergoemacs.org/emacs/elisp_get-selection-or-unit.html

(defun get-selection-or-unit (unit)
  "Return the string and boundary of text selection or UNIT under cursor.

If `region-active-p' is true, then the region is the unit.  Else,
it depends on the UNIT. See `unit-at-cursor' for detail about
UNIT.

Returns a vector [text a b], where text is the string and a and b
are its boundary.

Example usage:
 (setq bds (get-selection-or-unit 'line))
 (setq inputstr (elt bds 0) p1 (elt bds 1) p2 (elt bds 2)  )"
  (interactive)

  (let ((p1 (region-beginning)) (p2 (region-end)))
    (if (region-active-p)
        (vector (buffer-substring-no-properties p1 p2) p1 p2 )
      (unit-at-cursor unit) ) ) )

(defun unit-at-cursor  (unit)
  "Return the string and boundary of UNIT under cursor.

Returns a vector [text a b], where text is the string and a and b are its boundary.

UNIT can be:
• 'word — sequence of 0 to 9, A to Z, a to z, and hyphen.
• 'glyphs — sequence of visible glyphs. Useful for file name, URL, …, that doesn't have spaces in it.
• 'line — delimited by “\\n”.
• 'block — delimited by “\\n\\n” or beginning/end of buffer.
• 'buffer — whole buffer. (respects `narrow-to-region')
• a vector [beginRegex endRegex] — The elements are regex strings used to determine the beginning/end of boundary chars. They are passed to `skip-chars-backward' and `skip-chars-forward'. For example, if you want paren as delimiter, use [\"^(\" \"^)\"]

Example usage:
    (setq bds (unit-at-cursor 'line))
    (setq myText (elt bds 0) p1 (elt bds 1) p2 (elt bds 2)  )

This function is similar to `thing-at-point' and `bounds-of-thing-at-point'.
The main differences are:
• this function returns the text and the 2 boundaries as a vector in one shot.
• 'line always returns the line without end of line character, avoiding inconsistency when the line is at end of buffer.
• 'word does not depend on syntax table.
• 'block does not depend on syntax table."
  (let (p1 p2)
    (save-excursion
        (cond
         ( (eq unit 'word)
           (let ((wordcharset "-A-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ"))
             (skip-chars-backward wordcharset)
             (setq p1 (point))
             (skip-chars-forward wordcharset)
             (setq p2 (point)))
           )

         ( (eq unit 'glyphs)
           (progn
             (skip-chars-backward "[:graph:]")
             (setq p1 (point))
             (skip-chars-forward "[:graph:]")
             (setq p2 (point)))
           )

         ( (eq unit 'buffer)
           (progn
             (setq p1 (point-min))
             (setq p2 (point-max))
             )
           )

         ((eq unit 'line)
          (progn
            (setq p1 (line-beginning-position))
            (setq p2 (line-end-position))))
         ((eq unit 'block)
          (progn
            (if (re-search-backward "\n\n" nil t)
                (progn (forward-char 2)
                       (setq p1 (point) ) )
              (setq p1 (line-beginning-position) )
              )

            (if (re-search-forward "\n\n" nil t)
                (progn (backward-char)
                       (setq p2 (point) ))
              (setq p2 (line-end-position) ) ) ))

         ((vectorp unit)
          (let (p0)
             (setq p0 (point))
             (skip-chars-backward (elt unit 0))
             (setq p1 (point))
             (goto-char p0)
             (skip-chars-forward (elt unit 1))
             (setq p2 (point))))
         ) )

    (vector (buffer-substring-no-properties p1 p2) p1 p2 )
    ) )


;; Code copied from: http://ergoemacs.org/emacs/elisp_copy-paste_register_1.htmlx
(defun copy-to-register-1 ()
  "Copy current line or text selection to register 1.
See also: `paste-from-register-1', `copy-to-register'."
  (interactive)
  (let* (
         (bds (get-selection-or-unit 'line ))
         (inputStr (elt bds 0) )
         (p1 (elt bds 1) )
         (p2 (elt bds 2) )
         )
    (copy-to-register ?1 p1 p2)
    (message "copied to register 1: 「%s」." inputStr)
))

(defun paste-from-register-1 ()
  "Paste text from register 1.
See also: `copy-to-register-1', `insert-register'."
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert-register ?1 t))


(provide 'copy-paste-from-register)
