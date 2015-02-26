(defun python-docstring ()
  "Inserts a Python docstring"
  (interactive)
  (python-nav--beginning-of-defun)
  (end-of-line)
  (newline)
  (insert "\"\"\"")
  (indent-according-to-mode)
  (newline 2)
  (insert "\"\"\"")
  (indent-according-to-mode)
  (previous-line)
  (indent-according-to-mode)
)
