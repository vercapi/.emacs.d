;;; Package --- various utilities for emacs lisp

;;; Commentary: Just a bunch of helpers

;;; Code:

(cl-defun pve-last-char (text regexp &optional (idx 0))
  "Get the last occurence of REGEXP in a string TEXT.

- TEXT is the string to search.
- REGEXP is the regex to search for.
- IDX is the indext to start searching

Returns the positionf of the last found occurence of REGEXP"
  (let ((match (string-match-p (regexp-quote regexp) text idx)))
    (if match
        (pve-last-char text char (+ 1 match))
      (- idx 1))))

;;; utils.el ends here
