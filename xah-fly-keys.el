;;; xah-fly-keys.el --- ergonomic modal keybinding minor mode. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2013-2017, by Xah Lee

;; Author: Xah Lee ( http://xahlee.info/ )
;; Version: 8.2.20170924
;; Created: 10 Sep 2013
;; Package-Requires: ((emacs "24.1"))
;; Keywords: convenience, emulations, vim, ergoemacs
;; License: GPL v3
;; Homepage: http://ergoemacs.org/misc/ergoemacs_vi_mode.html

;; This file is not part of GNU Emacs.

;;; Commentary:

;; xah-fly-keys is a efficient keybinding for emacs. (more efficient than vim)

;; It is a modal mode like vi, but key choices are based on statistics of command call frequency.

;; --------------------------------------------------
;; MANUAL INSTALL

;; put the file xah-fly-keys.el in ~/.emacs.d/lisp/
;; create the dir if doesn't exist.

;; put the following in your emacs init file:

;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'xah-fly-keys)
;; (xah-fly-keys-set-layout "qwerty") ; required if you use qwerty
;; (xah-fly-keys-set-layout "qwertz") ; required if you use qwertz (Germany, etc.)
;; ;; (xah-fly-keys-set-layout "workman") ; required if you use workman
;; ;; (xah-fly-keys-set-layout "dvorak") ; by default, it's dvorak
;; (xah-fly-keys 1)

;; --------------------------------------------------
;; HOW TO USE

;; M-x xah-fly-keys to toggle the mode on/off.

;; Important command/insert mode switch keys:

;; xah-fly-command-mode-activate (press 【<home>】 or 【F8】 or 【Alt+Space】 or 【menu】)

;; xah-fly-insert-mode-activate  (when in command mode, press qwerty letter key f. (Dvorak key u))

;; When in command mode:
;; 【f】 (or Dvorak 【u】) activates insertion mode.
;; 【Space】 is a leader key. For example, 【SPACE r】 (Dvorak 【SPACE p】) calls query-replace. Press 【SPACE C-h】 to see the full list.
;; 【Space Space】 also activates insertion mode.
;; 【Space Enter】 calls execute-extended-command or smex (if smex is installed).
;; 【a】 calls execute-extended-command or smex (if smex is installed).

;; The leader key sequence basically replace ALL emacs commands that starts with C-x key.

;; When using xah-fly-keys, you don't need to press Control or Meta, with the following exceptions:

;; C-c for major mode commands.
;; C-g for cancel.
;; C-q for quoted-insert.
;; C-h for getting a list of keys following a prefix/leader key.

;; Leader key

;; You NEVER need to press Ctrl+x

;; Any emacs commands that has a keybinding starting with C-x, has also a key sequence binding in xah-fly-keys. For example,
;; 【C-x b】 switch-to-buffer is 【SPACE f】 (Dvorak 【SPACE u】)
;; 【C-x C-f】 find-file is 【SPACE i e】 (Dvorak 【SPACE c .】)
;; 【C-x n n】 narrow-to-region is 【SPACE l l】 (Dvorak 【SPACE n n】)
;; The first key we call it leader key. In the above examples, the SPACE is the leader key.

;; When in command mode, the 【SPACE】 is a leader key.

;; globally, the leader key is the 【f9】 key. 【f9】 is leader key regardless it's in command mode or insert mode.

;; the following stardard keys with Control are supported:

 ;; 【Ctrl+tab】 'xah-next-user-buffer
 ;; 【Ctrl+shift+tab】 'xah-previous-user-buffer
 ;; 【Ctrl+v】 paste
 ;; 【Ctrl+w】 close
 ;; 【Ctrl+z】 undo
 ;; 【Ctrl+n】 new
 ;; 【Ctrl+o】 open
 ;; 【Ctrl+s】 save
 ;; 【Ctrl+shift+s】 save as
 ;; 【Ctrl+shift+t】 open last clased
 ;; 【Ctrl++】 'text-scale-increase
 ;; 【Ctrl+-】 'text-scale-decrease
 ;; 【Ctrl+0】 (lambda () (interactive) (text-scale-set 0))))

;; I highly recommend setting 【capslock】 to send 【Home】. So that it acts as `xah-fly-command-mode-activate'.
;; see
;; How to Make the CapsLock Key do Home Key
;; http://ergoemacs.org/misc/capslock_do_home_key.html

;; If you have a bug, post on github. Or post comment xah-fly-keys home page for small questions.

;; For detail about design and other info, see home page at
;; http://ergoemacs.org/misc/ergoemacs_vi_mode.html

;; If you like this project, Buy Xah Emacs Tutorial http://ergoemacs.org/emacs/buy_xah_emacs_tutorial.html or make a donation. Thanks.

;;; Code:
(require 'dired) ; in emacs
(require 'dired-x) ; in emacs
(require 'ido) ; in emacs
(require 'xah-fly-layouts)
(require 'xah-fly-keymaps)

(when (version<= emacs-version "26.0.50"  )
  (defalias 'global-display-line-numbers-mode 'linum-mode ))

(defvar xah-fly-key-map-alist (list (cons 'xah-fly-keys xah-fly-generic-map)
									(cons 'xah-fly-command-state-q xah-fly-command-map)
									(cons 'xah-fly-insert-state-q  xah-fly-insert-map)))

(defvar xah-fly-command-mode-activate-hook nil "Hook for `xah-fly-command-mode-activate'")
(defvar xah-fly-insert-mode-activate-hook nil "Hook for `xah-fly-insert-mode-activate'")

(defun xah-fly-keys-set-layout (@layout)
  "Set a keyboard layout.
Possible value should be \"qwerty\", \"dvorak\" or \"workman\"
Version 2017-01-21"
  (interactive "M")
  (setq xah-fly-key--current-layout @layout)
  (load "xah-fly-keymaps")
  (xah-fly-command-mode-init)
  (xah-fly-insert-mode-init))

;; keymaps
(defvar xah-fly-swapped-1-8-and-2-7-p nil "If non-nil, it means keys 1 and 8 are swapped, and 2 and 7 are swapped. See: http://xahlee.info/kbd/best_number_key_layout.html")

(defvar xah-fly-insert-state-q t "Boolean value. true means insertion mode is on.")

(defvar xah-fly-command-state-q t "Boolean value. true means command mode is on.")

(defun xah-fly-set-state (state)
  "Set the state of xah-fly-keys."
  (setq xah-fly-insert-state-q nil)
  (setq xah-fly-command-state-q nil)
  (set state t))

(defun xah-fly-mode-toggle ()
  "Switch between {insertion, command} modes."
  (interactive)
  (if xah-fly-insert-state-q
      (xah-fly-command-mode-activate)
    (xah-fly-insert-mode-activate)))

(defun xah-fly-save-buffer-if-file ()
  "Save current buffer if it is a file."
  (interactive)
  (when (buffer-file-name)
    (save-buffer)))

(defun xah-fly-command-mode-activate ()
  "Activate command mode and run `xah-fly-command-mode-activate-hook'
Version 2017-07-07"
  (interactive)
  (xah-fly-set-state 'xah-fly-command-state-q)
  (modify-all-frames-parameters (list (cons 'cursor-type 'box)))
  (setq mode-line-front-space "▮")
  (force-mode-line-update)
  (run-hooks 'xah-fly-command-mode-activate-hook))

(defun xah-fly-command-mode-activate-no-hook ()
  "Activate command mode. Does not run `xah-fly-command-mode-activate-hook'
Version 2017-07-07"
  (interactive)
  (xah-fly-set-state 'xah-fly-command-state-q))

(defun xah-fly-insert-mode-activate ()
  "Activate insertion mode.
Version 2017-07-07"
  (interactive)
  (xah-fly-set-state 'xah-fly-insert-state-q)
  (modify-all-frames-parameters (list (cons 'cursor-type 'bar)))
  (setq mode-line-front-space "⌶")
  (force-mode-line-update)
  (run-hooks 'xah-fly-insert-mode-activate-hook))

(defun xah-fly-insert-mode-activate-newline ()
  "Activate insertion mode, insert newline below."
  (interactive)
  (xah-fly-insert-mode-activate)
  (open-line 1))

(defun open-line-insert ()
  "Opens a line below, moves the point and activate insert mode. 
Version 2017-10-08"
  (interactive)
  (end-of-line)
  (newline)
  (xah-fly-insert-mode-activate)
  (indent-for-tab-command))

(defun xah-fly-insert-mode-activate-space-before ()
  "Insert a space, then activate insertion mode."
  (interactive)
  (insert " ")
  (xah-fly-insert-mode-activate))

(defun xah-fly-insert-mode-activate-end-of-line-before ()
  "Go to end of line, then activate insertion mode."
  (interactive)
  (end-of-line)
  (xah-fly-insert-mode-activate))

(defun xah-fly-insert-mode-activate-space-after ()
  "Insert a space, then activate insertion mode."
  (interactive)
  (insert " ")
  (xah-fly-insert-mode-activate)
  (left-char))

;; ;; when in shell mode, switch to insertion mode.
;; (add-hook 'dired-mode-hook 'xah-fly-keys-off)

;; experimental. auto switch back to command mode after some sec of idle time
;; (setq xah-fly-timer-id (run-with-idle-timer 20 t 'xah-fly-command-mode-activate))
;; (cancel-timer xah-fly-timer-id)

(define-minor-mode xah-fly-keys
  "A modal keybinding set, like vim, but based on ergonomic principles, like Dvorak layout.
URL `http://ergoemacs.org/misc/ergoemacs_vi_mode.html'"
  t "∑flykeys"
  (progn
	;; Push mode map-alist
	(push 'xah-fly-key-map-alist emulation-mode-map-alists)
	;; initialize keymaps
	(xah-fly-command-mode-init)
	(xah-fly-insert-mode-init)
    ;; when going into minibuffer, switch to insertion mode.
    (add-hook 'minibuffer-setup-hook 'xah-fly-insert-mode-activate)
    (add-hook 'minibuffer-exit-hook 'xah-fly-command-mode-activate)
    ;; (add-hook 'xah-fly-command-mode-activate-hook 'xah-fly-save-buffer-if-file)
    ;; when in shell mode, switch to insertion mode.
    (add-hook 'shell-mode-hook 'xah-fly-insert-mode-activate)
	(xah-fly-command-mode-activate))
  ;; (add-to-list 'emulation-mode-map-alists (list (cons 'xah-fly-keys xah-fly-key-map )))
  ;; (add-to-list 'emulation-mode-map-alists '((cons xah-fly-keys xah-fly-key-map )))
)

(defun xah-fly-keys-off ()
  "Turn off xah-fly-keys minor mode."
  (interactive)
  (progn
	(xah-fly-insert-mode-activate)
	(setq emulation-mode-map-alists (delete 'xah-fly-key-map-alist emulation-mode-map-alists))
    (remove-hook 'minibuffer-setup-hook 'xah-fly-insert-mode-activate)
    (remove-hook 'minibuffer-exit-hook 'xah-fly-command-mode-activate)
    (remove-hook 'xah-fly-command-mode-activate-hook 'xah-fly-save-buffer-if-file)
    (remove-hook 'shell-mode-hook 'xah-fly-insert-mode-activate))
  (xah-fly-keys 0))

(provide 'xah-fly-keys)

;;; xah-fly-keys.el ends here
