(add-to-list 'load-path "~/.emacs.d/plugins/")
;; Preload:
;; ================
;; add all subdirs of plugins to load path:
(mapcar (lambda (dir) (add-to-list 'load-path dir)) (directory-files "~/.emacs.d/plugins/" 1 "^[-_a-zA-Z0-9]+$"))

;; Plugins:
;; ================
(setq plugin-error-list (list))
(defun load-plugin (plugin)
  "Safely requires the plugin - if an error occures, gracefuly add it to plugin-error-list"
  (let ((plugin-name (symbol-name plugin)))
    (condition-case
        exception
        (progn
          (message (format "Loading plugin \"%s\"..." plugin-name))
          (require plugin)
          (message (format "Plugin \"%s\" loaded successfully." plugin-name)))
      ('error
       (progn
         (add-to-list 'plugin-error-list plugin))
         (message (format "Error loading plugin \"%s\"." plugin-name))
      ))))

;; Minor modes / helpers:
(load-plugin 'git-emacs)
;(load-plugin 'newcomment)
;(load-plugin 'highlight-symbol)
;; (load-plugin 'maxframe)
;(load-plugin 'ido)
;(load-plugin 'recentf)
;(load-plugin 'dired-details)
;; (load-plugin 'dired-details-plus)
;; (load-plugin 'inline-string-rectangle)
;(load-plugin 'mark-more-like-this)
;(load-plugin 'move-lines)
;(load-plugin 'browse-kill-ring)
(load-plugin 'magit)


;; (load-plugin 'sr-speedbar)
;; Configurations:
;; ================

;; elscreen
;; (elscreen-start)

;;highlight-symbol

;(highlight-symbol-mode 1)

;;icicles
;; (icicle-mode)

;; web-mode

;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; deft
;; configuration based on http://emacs-fu.blogspot.co.il/2011/09/quick-note-taking-with-deft-and-org.html
;(when (require 'deft nil 'noerror)
;   (setq
;      deft-extension "org"
;      deft-directory "~/Dropbox/deft/"
;      deft-text-mode 'org-mode)
;   (global-set-key (kbd "<f9>") 'deft))
;
;;; auto-complete-mode
;(require 'auto-complete)
;(global-auto-complete-mode 1)
;
;;; my shortcut keys:
;(defun ac-jump-next ()
;  (interactive)
;  (dotimes (_ 3)
;    (ac-next)))
;
;(defun ac-jump-previous ()
;  (interactive)
;  (dotimes (_ 3)
;    (ac-previous)))
;
;;; (define-key ac-completing-map (kbd "C-n") 'ac-next)
;;; (define-key ac-completing-map (kbd "C-p") 'ac-previous)
;;; (define-key ac-completing-map (kbd "C-M-n") 'ac-jump-next)
;;; (define-key ac-completing-map (kbd "C-M-p") 'ac-jump-previous)
;
;;; http://stackoverflow.com/questions/8095715/emacs-auto-complete-mode-at-startup
;;; (defun auto-complete-mode-maybe ()
;;;   "No maybe for you. Only AC!"
;;;   (unless (minibufferp (current-buffer))
;;;     (auto-complete-mode 1)))
;
;;; http://stackoverflow.com/questions/12660428/emacs-auto-complete-dont-trigger-on-ret-in-inline-suggestion
;;; (define-key ac-completing-map "\C-m" nil)
;;; (define-key ac-completing-map (kbd "<tab>") nil)
;;; (setq ac-use-menu-map t)
;;; (define-key ac-menu-map "\C-m" 'ac-complete)
;
;;; ruby-mode special files:
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("capfile" . ruby-mode))
;
;;; fix Ruby indentation:
;;; https://gist.github.com/fujin/5173680
;(setq ruby-deep-indent-paren nil)
;(defadvice ruby-indent-line (after unindent-closing-paren activate)
;  (let ((column (current-column))
;        indent offset)
;    (save-excursion
;      (back-to-indentation)
;      (let ((state (syntax-ppss)))
;        (setq offset (- column (current-column)))
;        (when (and (eq (char-after) ?\))
;                   (not (zerop (car state))))
;          (goto-char (cadr state))
;          (setq indent (current-indentation)))))
;    (when indent
;      (indent-line-to indent)
;      (when (> offset 0) (forward-char offset)))))
;
;
;;; lua-mode
;(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;(add-to-list 'auto-mode-alist '("\\.ws$" . lua-mode))
;(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
;
;;; Display ido results vertically, rather than horizontally
;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;
;;;;max-frame
;;; (add-hook 'window-setup-hook 'maximize-frame t)
;;; (setq mf-max-width 1600)  ;; Pixel width of main monitor
;
;;;; ido-mode
;;; (setq ido-everywhere 1)
;;; (ido-mode 1)
;
;;;; display tooltips in the echo:
;(tooltip-mode -1)
;(setq tooltip-use-echo-area t)
;
;;;; recent-f
;(recentf-mode t)
;(recentf-cleanup)
;
;;; get rid of `find-file-read-only' and replace it with something more useful.
;(defun ido-recentf-open ()
;  "Use `ido-completing-read' to \\[find-file] a recent file"
;  (interactive)
;  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;      (message "Opening file...")
;    (message "Aborting")))
;
;;;Expand-region
;(global-set-key (kbd "C-=") 'er/expand-region)
;(global-set-key (kbd "C-+") 'er/contract-region)
;
;;; dired-details and plus
;(dired-details-install)
;
;;;mark-multiple
;(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
;(global-set-key (kbd "C-<") 'mark-previous-like-this)
;(global-set-key (kbd "C->") 'mark-next-like-this)
;
;;;; vi-like % paren matching
;(defun goto-match-paren (arg)
;  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
;vi style of % jumping to matching brace."
;  (interactive "p")
;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;        (t (self-insert-command (or arg 1)))))
;(global-set-key (kbd "C-%") 'goto-match-paren)
;
;;;js2
;(autoload 'js2-mode "js2-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;(js2r-add-keybindings-with-prefix "C-c C-m")
;
;
;;;js2-refactor
;;; Usage
;;; All refactorings start with C-c C-m and then a two-letter mnemonic shortcut.
;
;;; eo is expand-object: Converts a one line object literal to multiline.
;;; co is contract-object: Converts a multiline object literal to one line.
;;; wi is wrap-buffer-in-iife: Wraps the entire buffer in an immediately invoked function expression
;;; ig is inject-global-in-iife: Creates a shortcut for a marked global by injecting it in the wrapping immediately invoked function expression
;;; ag is add-to-globals-annotation: Creates a /*global */ annotation if it is missing, and adds the var at point to it.
;;; ev is extract-var: Takes a marked expression and replaces it with a var.
;;; iv is inline-var: Replaces all instances of a variable with its initial value.
;;; rv is rename-var: Renames the variable on point and all occurrences in its lexical scope.
;;; vt is var-to-this: Changes local var a to be this.a instead.
;;; ao is arguments-to-object: Replaces arguments to a function call with an object literal of named arguments. Requires yasnippets.
;;; 3i is ternary-to-if: Converts ternary operator to if-statement.
;;; sv is split-var-declaration: Splits a var with multiple vars declared, into several var statements.
;;; uw is unwrap: Replaces the parent statement with the selected region.
;;; There are also some minor conveniences bundled:
;
;;; C-S-down and C-S-up moves the current line up or down. If the line is an element in an object or array literal, it makes sure that the commas are still correctly placed.
;
;;; change magit diff colors
;(eval-after-load 'magit
;  '(progn
;     (set-face-foreground 'magit-diff-add "green3")
;     (set-face-foreground 'magit-diff-del "red3")
;     (when (not window-system)
;       (set-face-background 'magit-item-highlight "black"))))
;
;;;; munltiple cursors
;
;;;; full path in title
;(setq frame-title-format
;      (list
;       "Emacs24 - "
;       '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
;
;;;exec-path
;(exec-path-from-shell-initialize)
;(mapcar 'exec-path-from-shell-copy-env '())
;
;;;join-region
;(defun join-region (beg end)
;  "Apply join-line over region."
;  (interactive "r")
;  (if mark-active
;          (let ((beg (region-beginning))
;                        (end (copy-marker (region-end))))
;                (goto-char beg)
;                (while (< (point) end)
;                  (join-line 1)))))
;
;;; sudo-open file: http://emacs-fu.blogspot.co.il/2013/03/editing-with-root-privileges-once-more.html
;(defun djcb-find-file-as-root ()
;  "Like `ido-find-file, but automatically edit the file with
;root-privileges (using tramp/sudo), if the file is not writable by
;user."
;  (interactive)
;  (let ((file (ido-read-file-name "Edit as root: ")))
;    (unless (file-writable-p file)
;      (setq file (concat "/sudo:root@localhost:" file)))
;    (find-file file)))
;(global-set-key (kbd "C-x F") 'djcb-find-file-as-root)
;
;;; helm
;;; helm-mode is activated in dancar-init, don't know why it didn't work from here...
(require 'helm-ls-git)
;
(defun helm-dan ()
 (interactive)
 (require 'helm-files)
 (helm-other-buffer '(
                      helm-source-buffers-list
                      helm-source-bookmarks
                      helm-source-ls-git-status
                      helm-source-recentf
                      helm-source-ls-git
                      helm-source-buffer-not-found
                      )
                    "*helm dan*"))
;
(defun helm-dan-buffers ()
 (interactive)
 (require 'helm-files)
 (helm-other-buffer
  '(helm-source-buffers-list)
  "*helm dan buffers*"))
;
;;; line jump keys:
;(defun helm-big-jump-next-lines ()
;  (interactive)
;  (dotimes (_ 5)
;    (helm-next-line)))
;
;(defun helm-big-jump-previous-lines ()
;  (interactive)
;  (dotimes (_ 5)
;    (helm-previous-line)))
;
;(defun helm-jump-next-lines ()
;  (interactive)
;  (dotimes (_ 2)
;    (helm-next-line)))
;
;(defun helm-jump-previous-lines ()
;  (interactive)
;  (dotimes (_ 2)
;    (helm-previous-line)))
;
;(define-key helm-map (kbd "C-M-n") `helm-jump-next-lines)
;(define-key helm-map (kbd "C-M-p") `helm-jump-previous-lines)
;(define-key helm-map (kbd "C-M-S-n") `helm-big-jump-next-lines)
;(define-key helm-map (kbd "C-M-S-p") `helm-big-jump-previous-lines)
;
(provide 'dancar-plugins)
;;;;;;;;;;;;;;;;;;
