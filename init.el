
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cider haskell-mode plantuml-mode plantuml salt clipmon bm goto-last-change eaf eaf-mode ace-jump-mode highlight-parentheses all-the-icons visual-regexp pocket-mode pocket-api lsp-mode lsp-ui lsp-java company-lsp ob-async arch-packer hl-anything helm-ag-r helm-ag yasnippet xah-math-input which-key web-mode use-package undo-tree twittering-mode systemd syntax-subword sunrise-x-modeline sunrise-x-buttons sr-speedbar smex smartparens salt-mode rainbow-delimiters pymacs prodigy powerline popwin peep-dired pdf-tools pallet org-bullets nyan-mode multiple-cursors magit lua-mode jedi idle-highlight-mode hydra htmlize helm-spotify helm-projectile goto-chg git-gutter flycheck-pyflakes flycheck-cask expand-region exec-path-from-shell dsvn drag-stuff dockerfile-mode docker company-shell beacon avy anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "ProggyVector" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal))))
 '(minimap-font-face ((t (:height 40 :family "ProggyVector"))))
 '(mode-line ((t (:family "ProggyVector" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal))))
 '(org-level-1 ((t (:font "ProggyVector"))))
 '(org-level-2 ((t (:font "ProggyVector"))))
 '(org-level-3 ((t (:font "ProggyVector"))))
 '(org-level-4 ((t (:font "ProggyVector"))))
 '(org-level-5 ((t (:font "ProggyVector"))))
 '(org-level-6 ((t (:font "ProggyVector"))))
 '(org-level-7 ((t (:font "ProggyVector"))))
 '(org-level-8 ((t (:font "ProggyVector"))))
 '(treemacs-directory-face ((t :inherit default)))
 '(treemacs-git-untracked-face ((t :inherit default))))
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
