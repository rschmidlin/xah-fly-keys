
(defvar xah--dvorak-to-qwerty-kmap
  '(("." . "e")
    ("," . "w")
    ("'" . "q")
    (";" . "z")
    ("/" . "[")
    ("[" . "-")
    ("]" . "=")
    ("=" . "]")
    ("-" . "'")

    ("a" . "a")
    ("b" . "n")
    ("c" . "i")
    ("d" . "h")
    ("e" . "d")
    ("f" . "y")
    ("g" . "u")
    ("h" . "j")
    ("i" . "g")
    ("j" . "c")
    ("k" . "v")
    ("l" . "p")
    ("m" . "m")
    ("n" . "l")
    ("o" . "s")
    ("p" . "r")
    ("q" . "x")
    ("r" . "o")
    ("s" . ";")
    ("t" . "k")
    ("u" . "f")
    ("v" . ".")
    ("w" . ",")
    ("x" . "b")
    ("y" . "t")
    ("z" . "/"))
  "A alist, each element is of the form(\"e\" . \"d\"). First char is Dvorak, second is corresponding qwerty. Not all chars are in the list, such as digits. When not in this alist, they are assumed to be the same.")

(defvar xah--dvorak-to-qwertz-kmap
  '(("." . "e")
    ("," . "w")
    ("'" . "q")
    (";" . "y")
    ("/" . "ü")
	("[" . "ß")
    ("]" . "´")
	("=" . "+")
    ("-" . "ä")

    ("a" . "a")
    ("b" . "n")
    ("c" . "i")
    ("d" . "h")
    ("e" . "d")
    ("f" . "z")
    ("g" . "u")
    ("h" . "j")
    ("i" . "g")
    ("j" . "c")
    ("k" . "v")
    ("l" . "p")
    ("m" . "m")
    ("n" . "l")
    ("o" . "s")
    ("p" . "r")
    ("q" . "x")
    ("r" . "o")
    ("s" . "ö")
    ("t" . "k")
    ("u" . "f")
    ("v" . ".")
    ("w" . ",")
    ("x" . "b")
    ("y" . "t")
    ("z" . "-"))
    "A alist, each element is of the form(\"e\" . \"d\"). First char is Dvorak, second is corresponding qwertz. Not all chars are in the list, such as digits. When not in this alist, they are assumed to be the same.")

(defvar xah--dvorak-to-workman-kmap
  '(("'" . "q")
    ("," . "d")
    ("." . "r")
    ("p" . "w")
    ("y" . "b")
    ("f" . "j")
    ("g" . "f")
    ("c" . "u")
    ("r" . "p")
    ("l" . ";")
    ("a" . "a")
    ("o" . "s")
    ("e" . "h")
    ("u" . "t")
    ("i" . "g")
    ("d" . "y")
    ("h" . "n")
    ("t" . "e")
    ("n" . "o")
    ("s" . "i")
    (";" . "z")
    ("q" . "x")
    ("j" . "m")
    ("k" . "c")
    ("x" . "v")
    ("b" . "k")
    ("m" . "l")
    ("w" . ",")
    ("v" . ".")
    ("z" . "/"))
  "A alist, each element is of the form(\"e\" . \"d\"). First char is dvorak, second is corresponding workman. Not all chars are in the list, such as digits. When not in this alist, they are assumed to be the same.")

(defun xah--dvorak-to-qwertz (@charstr)
  "Convert dvorak key to qwertz. @charstr is a string of single char.
For example, \"e\" becomes \"d\".
If  length of @CHARSTR is greater than 1, such as \"TAB\", @CHARSTR is returned unchanged.
Version 2017-09-13"
  (interactive)
  (if (> (length @charstr) 1)
      @charstr
    (let (($result (assoc @charstr xah--dvorak-to-qwertz-kmap)))
      (if $result
          (cdr $result)
        @charstr
        ))))

(defun xah--dvorak-to-qwerty (@charstr)
  "Convert dvorak key to qwerty. @charstr is a string of single char.
For example, \"e\" becomes \"d\".
If  length of @CHARSTR is greater than 1, such as \"TAB\", @CHARSTR is returned unchanged.
Version 2017-02-10"
  (interactive)
  (if (> (length @charstr) 1)
      @charstr
    (let (($result (assoc @charstr xah--dvorak-to-qwerty-kmap)))
      (if $result
          (cdr $result)
        @charstr
        ))))

(defun xah--dvorak-to-workman (@charstr)
  "Convert dvorak key to workman. @charstr is a string of single char.
For example, \"e\" becomes \"d\".
If  length of @CHARSTR is greater than 1, such as \"TAB\", @CHARSTR is returned unchanged.
Version 2017-07-27"
  (interactive)
  (if (> (length @charstr) 1)
      @charstr
    (let (($result (assoc @charstr xah--dvorak-to-workman-kmap)))
      (if $result
          (cdr $result)
        @charstr
        ))))

(defun xah-fly--key-char (@charstr)
  "Return the corresponding char @CHARSTR according to current `xah-fly-key--current-layout'.
@CHARSTR must be a string of single char. Default layout is dvorak.
Version 2017-07-27"
  (interactive)
  (cond
   ((string-equal xah-fly-key--current-layout "qwerty") (xah--dvorak-to-qwerty @charstr))
   ((string-equal xah-fly-key--current-layout "qwertz") (xah--dvorak-to-qwertz @charstr))
   ((string-equal xah-fly-key--current-layout "workman") (xah--dvorak-to-workman @charstr))
   (t @charstr)))

(provide 'xah-fly-layouts)
