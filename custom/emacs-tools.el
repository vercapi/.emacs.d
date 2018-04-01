
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

(defun pve-copy-full-file-name-to-clipboard ()
  "Copy the current buffer file name and path to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun pve-copy-file-name-to-clipboard ()
  "Copy the current buffer name to the clipboard, only the name of the file or current directory."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      (string-match "[^/]+/*$" default-directory)
                    (buffer-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;;; emacs-tools.el ends here
