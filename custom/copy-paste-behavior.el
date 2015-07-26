(defun custom-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region')."
  (interactive)
  (let (Sp1 Sp2)
    (if current-prefix-arg
        (progn (setq Sp1 (point-min))
               (setq Sp2 (point-max)))
      (progn (if (use-region-p)
                 (progn (setq Sp1 (region-beginning))
                        (setq Sp2 (region-end)))
               (progn (setq Sp1 (line-beginning-position))
                      (setq Sp2 (line-beginning-position 2))))))
    (kill-region Sp1 Sp2)))

(defun custom-copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region')."
  (interactive)
  (let (Sp1 Sp2)
    (if current-prefix-arg
        (progn (setq Sp1 (point-min))
               (setq Sp2 (point-max)))
      (progn (if (use-region-p)
                 (progn (setq Sp1 (region-beginning))
                        (setq Sp2 (region-end)))
               (progn (setq Sp1 (line-beginning-position))
                      (setq Sp2 (line-end-position))))))
    (kill-ring-save Sp1 Sp2)
    (if current-prefix-arg
        (message "buffer text copied")
      (message "text copied"))))
