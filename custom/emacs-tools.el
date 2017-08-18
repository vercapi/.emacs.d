
;;; Commentary

;;; Code:

(defun pve-small-fonts ()
  "Set font to work on desktop screens."
  (interactive)
  (pve-set-fonts 100)
  )

(defun pve-big-fonts ()
  "Set font for use on laptop screens."
   (interactive)
  (pve-set-fonts 140)
  )

(defun pve-set-fonts (font-height)
  "Set size of fonts to FONT-HEIGHT, and only the size of the fonts."
  (set-face-attribute 'default nil :height font-height)
  (set-face-attribute 'mode-line nil :height font-height)
  )

;;; emacs-tools.el ends here
