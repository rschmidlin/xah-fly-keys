(require 'xah-fly-commands)
(require 'xah-fly-layouts)

(defvar xah-fly-key-map (make-sparse-keymap) "Keybinding for `xah-fly-keys' minor mode.")

(defvar xah-fly-use-control-key t "if nil, do not bind any control key. When t, standard keys for open, close, paste, are bound.")
(defvar xah-fly-use-meta-key t "if nil, do not bind any meta key.")


(defun xah-fly--define-keys (@keymap-name @key-cmd-alist)
  "Map `define-key' over a alist @key-cmd-alist.
Example usage:
;; (xah-fly--define-keys
;;  (define-prefix-command 'xah-fly-dot-keymap)
;;  '(
;;    (\"h\" . highlight-symbol-at-point)
;;    (\".\" . isearch-forward-symbol-at-point)
;;    (\"1\" . hi-lock-find-patterns)
;;    (\"w\" . isearch-forward-word)))
Version 2017-01-21"
  (interactive)
  (mapc
   (lambda ($pair)
     (define-key @keymap-name (xah-fly--key-char (kbd (car $pair))) (cdr $pair)))
   @key-cmd-alist))

;; commands in search-map and facemenu-keymap
(xah-fly--define-keys
 (define-prefix-command 'xah-fly-dot-keymap)
 '(

   ("b" . facemenu-set-bold)
   ("f" . font-lock-fontify-block)
   ("c" . center-line)
   ("d" . facemenu-set-default)

   ("h" . highlight-symbol-at-point)
   ;; temp
   ("." . isearch-forward-symbol-at-point)
   ("1" . hi-lock-find-patterns)
   ("2" . highlight-lines-matching-regexp)
   ("3" . highlight-phrase)
   ("4" . highlight-regexp)
   ("5" . unhighlight-regexp)
   ("6" . hi-lock-write-interactive-patterns)
   ("s" . isearch-forward-symbol)
   ("w" . isearch-forward-word)

   ("i" . facemenu-set-italic)
   ("l" . facemenu-set-bold-italic)
   ("o" . facemenu-set-face)
   ("p" . center-paragraph)

   ("u" . facemenu-set-underline)
   ))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly--tab-key-map)
 '(
   ("TAB" . indent-for-tab-command)

   ("i" . complete-symbol)
   ("g" . indent-rigidly)
   ("r" . indent-region)
   ("s" . indent-sexp)

   ;; temp
   ("1" . abbrev-prefix-mark)
   ("2" . edit-abbrevs)
   ("3" . expand-abbrev)
   ("4" . expand-region-abbrevs)
   ("5" . unexpand-abbrev)
   ("6" . add-global-abbrev)
   ("7" . add-mode-abbrev)
   ("8" . inverse-add-global-abbrev)
   ("9" . inverse-add-mode-abbrev)
   ("0" . expand-jump-to-next-slot)
   ("=" . expand-jump-to-previous-slot)))



(xah-fly--define-keys
 (define-prefix-command 'xah-fly-c-keymap)
 '(
   ("," . xah-open-in-external-app)
   ("." . find-file)
   ("c" . bookmark-bmenu-list)
   ("e" . ibuffer)
   ("u" . xah-open-file-at-cursor)
   ("h" . recentf-open-files)
   ("l" . bookmark-set)
   ("n" . xah-new-empty-buffer)
   ("o" . xah-open-in-desktop)
   ("p" . xah-open-last-closed)
   ("f" . xah-open-recently-closed)
   ("y" . xah-list-recently-closed)
   ("r" . xah-open-file-fast)
   ("s" . write-file)
   ))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-h-keymap)
 '(
   (";" . Info-goto-emacs-command-node)
   ("a" . apropos-command)
   ("b" . describe-bindings)
   ("c" . describe-char)
   ("d" . apropos-documentation)
   ("e" . view-echo-area-messages)
   ("f" . describe-face)
   ("g" . info-lookup-symbol)
   ("h" . describe-function)
   ("i" . info)
   ("j" . man)
   ("k" . describe-key)
   ("K" . Info-goto-emacs-key-command-node)
   ("l" . view-lossage)
   ("m" . xah-describe-major-mode)
   ("n" . describe-variable)
   ("o" . describe-language-environment)
   ("p" . finder-by-keyword)
   ("r" . apropos-variable)
   ("s" . describe-syntax)
   ("u" . elisp-index-search)
   ("v" . apropos-value)
   ("z" . describe-coding-system)))

(xah-fly--define-keys
 ;; commands here are harmless (safe). They don't modify text.
 ;; they turn on minor/major mode, change display, prompt, start shell, etc.
 (define-prefix-command 'xah-fly-n-keymap)
 '(
   ("SPC" . whitespace-mode)
   ("RET" . nil)
   ("TAB" . nil)
   ("DEL" . nil)
   ("," . abbrev-mode)
   ("." . toggle-frame-fullscreen)
   ("'" . frame-configuration-to-register)
   (";" . window-configuration-to-register)
   ("1" . set-input-method)
   ("2" . global-hl-line-mode)
   ("4" . global-display-line-numbers-mode)
   ("5" . visual-line-mode)
   ("6" . calendar)
   ("7" . calc)
   ("8" . nil)
   ("9" . shell-command)
   ("0" . shell-command-on-region)
   ("a" . text-scale-adjust)
   ("b" . toggle-debug-on-error)
   ("c" . toggle-case-fold-search)
   ("d" . narrow-to-page)
   ("e" . eshell)
   ("f" . nil)
   ("g" . dash-at-point-with-docset)
   ("h" . widen)
   ("i" . make-frame-command)
   ("j" . flyspell-buffer)
   ("k" . menu-bar-open)
   ("l" . toggle-word-wrap)
   ("m" . nil)
   ("n" . narrow-to-region)
   ("o" . variable-pitch-mode)
   ("p" . read-only-mode)
   ("q" . jump-to-register)
   ("r" . nil)
   ("s" . nil)
   ("t" . narrow-to-defun)
   ("u" . shell)
   ("v" . nil)
   ("w" . eww)
   ("x" . save-some-buffers)
   ("y" . dash-at-point)
   ("z" . abort-recursive-edit)))

(xah-fly--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-r-keymap)
 '(
   ("SPC" . rectangle-mark-mode)
   ("," . apply-macro-to-region-lines)
   ("." . kmacro-start-macro)
   ("3" . number-to-register)
   ("4" . increment-register)
   ("a" . xah-upcase-sentence)
   ("c" . replace-rectangle)
   ("d" . delete-rectangle)
   ("e" . call-last-kbd-macro)
   ("g" . kill-rectangle)
   ("l" . clear-rectangle)
   ("i" . xah-space-to-newline)
   ("n" . rectangle-number-lines)
   ("o" . open-rectangle)
   ("p" . kmacro-end-macro)
   ("r" . yank-rectangle)
   ("u" . xah-quote-lines)
   ("y" . delete-whitespace-rectangle)))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-t-keymap)
 '(
   ("SPC" . xah-clean-whitespace)
   ("TAB" . move-to-column)
   ("1" . xah-clear-register-1)
   ("2" . xah-append-to-register-1)
   ("3" . xah-copy-to-register-1)
   ("4" . xah-paste-from-register-1)
   ("." . sort-lines)
   ("," . sort-numeric-fields)
   ("'" . reverse-region)
   ("a" . next-error)
   ("b" . previous-error)
   ("c" . goto-char)
   ("d" . mark-defun)
   ("e" . list-matching-lines)
   ("f" . goto-line )
   ("h" . xah-close-current-buffer )
   ("i" . delete-non-matching-lines)
   ("j" . copy-to-register)
   ("k" . insert-register)
   ("l" . xah-escape-quotes)
   ("m" . xah-make-backup-and-save)
   ("n" . repeat-complex-command)
   ("p" . query-replace-regexp)
   ("r" . copy-rectangle-to-register)
   ("o" . swiper)
   ("t" . repeat)
   ("u" . delete-matching-lines)
   ("w" . xah-next-window-or-frame)
   ("y" . delete-duplicate-lines)
   ("z" . nil)))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-w-keymap)
 '(
   ("DEL" . xah-delete-current-file)
   ("." . eval-buffer)
   ("e" . eval-defun)
   ("m" . eval-last-sexp)
   ("p" . eval-expression)
   ("u" . eval-region)
   ("q" . save-buffers-kill-terminal)
   ("w" . delete-frame)
   ("j" . xah-run-current-file)))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-e-keymap)
 '(
   ("RET" . insert-char)
   ("SPC" . xah-insert-unicode)
   ("b" . xah-insert-black-lenticular-bracket【】)
   ("c" . xah-insert-ascii-single-quote)
   ("d" . xah-insert-double-curly-quote“”)
   ("f" . xah-insert-emacs-quote)
   ("g" . xah-insert-ascii-double-quote)
   ("h" . xah-insert-brace) ; {}
   ("i" . xah-insert-curly-single-quote‘’)
   ("l" . xah-insert-form-feed)
   ("m" . xah-insert-corner-bracket「」)
   ("n" . xah-insert-square-bracket) ; []
   ("p" . xah-insert-single-angle-quote‹›)
   ("r" . xah-insert-tortoise-shell-bracket〔〕 )
   ("s" . xah-insert-string-assignment)
   ("t" . xah-insert-paren)
   ("u" . xah-insert-date)
   ("w" . xah-insert-angle-bracket〈〉)
   ("W" . xah-insert-double-angle-bracket《》)
   ("y" . xah-insert-double-angle-quote«»)))

;; (xah-fly--define-keys
;;  (define-prefix-command 'xah-coding-system-keymap)
;;  '(
;;    ("n" . set-file-name-coding-system)
;;    ("s" . set-next-selection-coding-system)
;;    ("c" . universal-coding-system-argument)
;;    ("f" . set-buffer-file-coding-system)
;;    ("k" . set-keyboard-coding-system)
;;    ("l" . set-language-environment)
;;    ("p" . set-buffer-process-coding-system)
;;    ("r" . revert-buffer-with-coding-system)
;;    ("t" . set-terminal-coding-system)
;;    ("x" . set-selection-coding-system)))

(xah-fly--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-comma-keymap)
 '(
   ("'" . with-editor-finish)
   ("," . org-capture)
   ("c" . cscope-find-functions-calling-this-function)
   ("e" . projectile-find-dir)
   ("f" . xah-fly-cancel-edit)
   ("g" . senator-go-to-up-reference)
   ("j" . org-ctrl-c-ctrl-c)
   ("k" . org-ctrl-c-minus)
   ("l" . cscope-find-this-symbol)
   ("m" . org-refile)
   ("n" . xref-pop-marker-stack)
   ("p" . gdb)
   ("q" . pdflatex)
   ("r" . cscope-find-called-functions)
   ("s" . xref-find-references)
   ("t" . xref-find-definitions)
   ("u" . ggtags-find-file)
   ("x" . compile)
   ("y" . pdb)
   ("i" . magit-status)))

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-leader-key-map)
 '(
   ("SPC" . xah-fly-insert-mode-activate)
   ("DEL" . xah-fly-insert-mode-activate)
   ("RET" . execute-extended-command)
   ("TAB" . xah-fly--tab-key-map)

   ("." . xah-fly-dot-keymap)
   ("'" . xah-fill-or-unfill)
   ("," . xah-fly-comma-keymap)
   ("-" . xah-display-form-feed-as-line)
   ("/" . nil)
   (";" . set-fill-column)
   ("=" . nil)
   ("[" . nil)
   ("\\" . toggle-input-method)
   ("`" . nil)

   ("1" . nil)
   ("2" . nil)
   ("3" . delete-window)
   ("4" . split-window-right)
   ("5" . balance-windows)
   ("6" . nil)
   ("7" . nil)
   ("8" . nil)
   ("9" . ispell-word)
   ("0" . transpose-lines)

   ("a" . mark-whole-buffer)
   ("b" . end-of-buffer)
   ("c" . xah-fly-c-keymap)
   ("d" . beginning-of-buffer)
   ("e" . xah-fly-e-keymap)
   ("f" . xah-search-current-word)
   ("g" . isearch-forward)
   ("h" . xah-fly-h-keymap)
   ("i" . xah-copy-file-path)
   ("j" . xah-copy-all-or-region)
   ("k" . xah-paste-or-paste-previous)
   ("l" . recenter-top-bottom)
   ("m" . dired-jump)
   ("n" . xah-fly-n-keymap)
   ("o" . exchange-point-and-mark)
   ("p" . query-replace)
   ("q" . xah-cut-all-or-region)
   ("r" . xah-fly-r-keymap)
   ("s" . save-buffer)
   ("t" . xah-fly-t-keymap)
   ("u" . switch-to-buffer)
   ("v" . nil)
   ("w" . xah-fly-w-keymap)
   ("x" . nil)
   ("y" . xah-show-kill-ring)
   ("z" . nil)
   ;;
   ))




;;;; misc

;; the following have keys in emacs, but right now i decided not to give them a key, because either they are rarely used (say, less than once a month by 90% of emacs users), or there is a more efficient command/workflow with key in xah-fly-keys

;; C-x C-p	mark-page
;; C-x C-l	downcase-region
;; C-x C-u	upcase-region

;; C-x C-t	transpose-lines
;; C-x C-o	delete-blank-lines

;; C-x C-r	find-file-read-only
;; C-x C-v	find-alternate-file

;; C-x =	what-cursor-position, use describe-char instead
;; C-x <	scroll-left
;; C-x >	scroll-right
;; C-x [	backward-page
;; C-x ]	forward-page
;; C-x ^	enlarge-window

;; C-x {	shrink-window-horizontally
;; C-x }	enlarge-window-horizontally
;; C-x DEL	backward-kill-sentence

;; C-x C-z	suspend-frame

;; C-x k	kill-buffer , use xah-close-current-buffer
;; C-x l	count-lines-page
;; C-x m	compose-mail


;; undecided yet

;; C-x e	kmacro-end-and-call-macro
;; C-x q	kbd-macro-query
;; C-x C-k	kmacro-keymap

;; C-x C-d	list-directory
;; C-x C-n	set-goal-column
;; C-x ESC	Prefix Command
;; C-x $	set-selective-display
;; C-x *	calc-dispatch
;; C-x -	shrink-window-if-larger-than-buffer
;; C-x .	set-fill-prefix

;; C-x 4	ctl-x-4-prefix
;; C-x 5	ctl-x-5-prefix
;; C-x 6	2C-command
;; C-x ;	comment-set-column

;; C-x `	next-error
;; C-x f	set-fill-column
;; C-x i	insert-file
;; C-x n	Prefix Command
;; C-x r	Prefix Command

;; C-x C-k C-a	kmacro-add-counter
;; C-x C-k C-c	kmacro-set-counter
;; C-x C-k C-d	kmacro-delete-ring-head
;; C-x C-k C-e	kmacro-edit-macro-repeat
;; C-x C-k C-f	kmacro-set-format
;; C-x C-k TAB	kmacro-insert-counter
;; C-x C-k C-k	kmacro-end-or-call-macro-repeat
;; C-x C-k C-l	kmacro-call-ring-2nd-repeat
;; C-x C-k RET	kmacro-edit-macro
;; C-x C-k C-n	kmacro-cycle-ring-next
;; C-x C-k C-p	kmacro-cycle-ring-previous
;; C-x C-k C-s	kmacro-start-macro
;; C-x C-k C-t	kmacro-swap-ring
;; C-x C-k C-v	kmacro-view-macro-repeat
;; C-x C-k SPC	kmacro-step-edit-macro
;; C-x C-k b	kmacro-bind-to-key
;; C-x C-k e	edit-kbd-macro
;; C-x C-k l	kmacro-edit-lossage
;; C-x C-k n	kmacro-name-last-macro
;; C-x C-k q	kbd-macro-query
;; C-x C-k r	apply-macro-to-region-lines
;; C-x C-k s	kmacro-start-macro



;; C-x 4 C-f	find-file-other-window
;; C-x 4 C-o	display-buffer
;; C-x 4 .	find-tag-other-window
;; C-x 4 0	kill-buffer-and-window
;; C-x 4 a	add-change-log-entry-other-window
;; C-x 4 b	switch-to-buffer-other-window
;; C-x 4 c	clone-indirect-buffer-other-window
;; C-x 4 d	dired-other-window
;; C-x 4 f	find-file-other-window
;; C-x 4 m	compose-mail-other-window
;; C-x 4 r	find-file-read-only-other-window

;; C-x 6 2	2C-two-columns
;; C-x 6 b	2C-associate-buffer
;; C-x 6 s	2C-split
;; C-x 6 <f2>	2C-two-columns

;; ctl-x-5-map

;; r C-f     find-file-other-frame
;; r C-o     display-buffer-other-frame
;; r .       find-tag-other-frame
;; r 0       delete-frame
;; r 1       delete-other-frames
;; r 2       make-frame-command
;; r b       switch-to-buffer-other-frame
;; r d       dired-other-frame
;; r f       find-file-other-frame
;; r m       compose-mail-other-frame
;; r o       other-frame
;; r r       find-file-read-only-other-frame

;; (xah-fly--define-keys
;;  (define-prefix-command 'xah-leader-vc-keymap)
;;  '(
;;    ("+" . vc-update)
;;    ("=" . vc-diff)
;;    ("D" . vc-root-diff)
;;    ("L" . vc-print-root-log)
;;    ("a" . vc-update-change-log)
;;    ("b" . vc-switch-backend)
;;    ("c" . vc-rollback)
;;    ("d" . vc-dir)
;;    ("g" . vc-annotate)
;;    ("h" . vc-insert-headers)
;;    ("l" . vc-print-log)
;;    ("m" . vc-merge)
;;    ("r" . vc-retrieve-tag)
;;    ("s" . vc-create-tag)
;;    ("u" . vc-revert)
;;    ("v" . vc-next-action)
;;    ("~" . vc-revision-other-window)))


;; setting keys

(progn

  (progn
    (define-key xah-fly-key-map (kbd "<home>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<menu>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<f8>") 'xah-fly-command-mode-activate-no-hook)

    (define-key xah-fly-key-map (kbd "<f9>") xah-fly-leader-key-map)

    (define-key xah-fly-key-map (kbd "<f11>") 'xah-previous-user-buffer)
    (define-key xah-fly-key-map (kbd "<f12>") 'xah-next-user-buffer)
    (define-key xah-fly-key-map (kbd "<C-f11>") 'xah-previous-emacs-buffer)
    (define-key xah-fly-key-map (kbd "<C-f12>") 'xah-next-emacs-buffer))

  (progn
    ;; set arrow keys in isearch. left/right is backward/forward, up/down is history. press Return to exit
    (define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat )
    (define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance )

    (define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward)
    (define-key isearch-mode-map (kbd "<right>") 'isearch-repeat-forward)

    (define-key minibuffer-local-isearch-map (kbd "<left>") 'isearch-reverse-exit-minibuffer)
    (define-key minibuffer-local-isearch-map (kbd "<right>") 'isearch-forward-exit-minibuffer)
    ;;
    )
  ;;
  (when xah-fly-use-control-key
    (progn
      (define-key xah-fly-key-map (kbd "<C-prior>") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-next>") 'xah-next-user-buffer)

      (define-key xah-fly-key-map (kbd "C-2") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "C-1") 'xah-next-user-buffer)

      (define-key xah-fly-key-map (kbd "<C-S-prior>") 'xah-previous-emacs-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-next>") 'xah-next-emacs-buffer)

      (define-key xah-fly-key-map (kbd "<C-tab>") 'xah-next-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-tab>") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-iso-lefttab>") 'xah-previous-user-buffer)

      (define-key xah-fly-key-map (kbd "C-9") 'scroll-down-command)
      (define-key xah-fly-key-map (kbd "C-0") 'scroll-up-command)

      (define-key xah-fly-key-map (kbd "C-SPC") 'xah-fly-leader-key-map)

      (define-key xah-fly-key-map (kbd "C-a") 'mark-whole-buffer)
      (define-key xah-fly-key-map (kbd "C-n") 'xah-new-empty-buffer)
      (define-key xah-fly-key-map (kbd "C-S-n") 'make-frame-command)
      (define-key xah-fly-key-map (kbd "C-o") 'find-file)
      (define-key xah-fly-key-map (kbd "C-s") 'save-buffer)
      (define-key xah-fly-key-map (kbd "C-S-s") 'write-file)
      (define-key xah-fly-key-map (kbd "C-S-t") 'xah-open-last-closed)
      (define-key xah-fly-key-map (kbd "C-v") 'yank)
      (define-key xah-fly-key-map (kbd "C-w") 'xah-close-current-buffer)
      (define-key xah-fly-key-map (kbd "C-z") 'undo)

      (define-key xah-fly-key-map (kbd "C-3") 'previous-error)
      (define-key xah-fly-key-map (kbd "C-4") 'next-error)

      (define-key xah-fly-key-map (kbd "C-+") 'text-scale-increase)
      (define-key xah-fly-key-map (kbd "C--") 'text-scale-decrease)

      (define-key xah-fly-key-map (kbd "C-t") nil) ; never do transpose-chars

      ;;
      ))

  (progn
    (when xah-fly-use-meta-key
      (define-key xah-fly-key-map (kbd "M-SPC") 'xah-fly-command-mode-activate)))
  ;;
  )

(defun backward-kill-line
	"Kills a line backwards from point"
  (interactive)
  (kill-line -1))

(defun xah-fly-command-mode-init ()
  "Set command mode keys.
Version 2017-01-21"
  (interactive)
  (xah-fly--define-keys
   xah-fly-key-map
   '(
     ("~" . nil)
     (":" . nil)

     ("SPC" . xah-fly-leader-key-map)
     ("DEL" . xah-fly-leader-key-map)

     ("'" . xah-reformat-lines)
     ("," . xah-shrink-whitespaces)
     ("-" . xah-cycle-hyphen-underscore-space)
     ("." . backward-kill-word)
     (";" . xah-comment-dwim)
     ("/" . hippie-expand)
     ("\\" . nil)
     ("=" . xah-forward-equal-sign)
     ("[" . xah-backward-punct )
     ("]" . xah-forward-punct)
     ("`" . other-frame)

     ;; ("#" . xah-backward-quote)
     ;; ("$" . xah-forward-punct)

     ("1" . pop-global-mark)
     ("2" . xah-pop-local-mark-ring)
     ("3" . delete-other-windows)
     ("4" . split-window-below)
     ("5" . delete-char)
     ("6" . xah-select-block)
     ("7" . xah-select-current-line)
     ("8" . xah-extend-selection)
     ("9" . xah-select-text-in-quote)
     ("0" . transpose-words)

     ("a" . execute-extended-command)
     ("b" . isearch-forward)
     ("c" . previous-line)
     ("d" . xah-beginning-of-line-or-block)
     ("e" . xah-delete-backward-char-or-bracket-text)
     ("f" . undo)
     ("g" . backward-word)
     ("h" . backward-char)
     ("i" . kill-line)
	 ("I" . backward-kill-line)
     ("j" . xah-copy-line-or-region)
     ("k" . xah-paste-or-paste-previous)
     ("l" . xah-fly-insert-mode-activate-end-of-line-before)
     ("m" . xah-backward-left-bracket)
     ("n" . forward-char)
     ("o" . open-line-insert)
     ("p" . kill-word)
     ("q" . xah-cut-line-or-region)
     ("r" . forward-word)
     ("s" . xah-end-of-line-or-block)
     ("t" . next-line)
     ("u" . xah-fly-insert-mode-activate)
     ("v" . xah-forward-right-bracket)
     ("w" . xah-next-window-or-frame)
     ("x" . xah-toggle-letter-case)
     ("y" . set-mark-command)
     ("z" . xah-goto-matching-bracket)))

  (define-key xah-fly-key-map (kbd "a") (if (fboundp 'counsel-M-x) 'counsel-M-x (if (fboundp 'smex) 'smex 'execute-extended-command )))
  (when xah-fly-swapped-1-8-and-2-7-p
    (xah-fly--define-keys
     xah-fly-key-map
     '(
       ("8" . pop-global-mark)
       ("7" . xah-pop-local-mark-ring)
       ("2" . xah-select-current-line)
       ("1" . xah-extend-selection))))

  (progn
    (setq xah-fly-insert-state-q nil )
    (modify-all-frames-parameters (list (cons 'cursor-type 'box))))

  (setq mode-line-front-space "▮")
  (force-mode-line-update)

  ;;
  )

(defun xah-fly-insert-mode-init ()
  "Set insertion mode keys"
  (interactive)
  ;; (setq xah-fly-key-map (make-sparse-keymap))
  ;; (setq xah-fly-key-map (make-keymap))

  (xah-fly--define-keys
   xah-fly-key-map
   '(

     ("SPC" . nil)
     ("DEL" . nil)

     ("'" . nil)
     ("," . nil)
     ("-" . nil)
     ("." . nil)
     ("/" . nil)
     (";" . nil)
     ("=" . nil)
     ("[" . nil)
     ("\\" . nil)
     ("]" . nil)
     ("`" . nil)
     ("~" . nil)

     ;; ("#" . nil)
     ;; ("$" . nil)

     ("1" . nil)
     ("2" . nil)
     ("3" . nil)
     ("4" . nil)
     ("5" . nil)
     ("6" . nil)
     ("7" . nil)
     ("8" . nil)
     ("9" . nil)
     ("0" . nil)

     ("a" . nil)
     ("b" . nil)
     ("c" . nil)
     ("d" . nil)
     ("e" . nil)
     ("f" . nil)
     ("g" . nil)
     ("h" . nil)
     ("i" . nil)
     ("j" . nil)
     ("k" . nil)
     ("l" . nil)
     ("m" . nil)
     ("n" . nil)
     ("o" . nil)
     ("p" . nil)
     ("q" . nil)
     ("r" . nil)
     ("s" . nil)
     ("t" . nil)
     ("u" . nil)
     ("v" . nil)
     ("w" . nil)
     ("x" . nil)
     ("y" . nil)
     ("z" . nil)

     ;;
     ))

  (progn
    (setq xah-fly-insert-state-q t )
    (modify-all-frames-parameters (list (cons 'cursor-type 'bar))))

(setq mode-line-front-space "⌶")
(force-mode-line-update)

  ;;
)

(provide 'xah-fly-keymaps)
