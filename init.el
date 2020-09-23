
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(which-key vterm visual-regexp undo-tree twittering-mode treemacs-projectile sunrise-commander speed-type salt-mode rfc-mode rainbow-delimiters quelpa-use-package pyvenv python-mode powerline pocket-mode plantuml-mode pdf-tools pcap-mode parse-csv orgit org-present org-gcal org-download org-bullets openapi-yaml-mode ob-restclient ob-async nord-theme magit-gitflow lyrics lua-mode lsp-ui lsp-java loccur lastpass java-snippets indium impatient-mode helm-xref helm-swoop helm-projectile helm-org helm-icons haskell-mode goto-last-change flycheck flucui-themes fish-completion eyebrowse expand-region excorporate eros dockerfile-mode docker dired-quick-sort diminish company-tern company-restclient company-lsp company-box clipmon cider bm beacon avy-zap angular-snippets all-the-icons ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "ProggyVector" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal))))
 '(minimap-font-face ((t (:height 40 :family "ProggyVector"))))
 '(mode-line ((t (:family "ProggyVector" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal))))
 '(treemacs-directory-face ((t :inherit default)))
 '(treemacs-git-untracked-face ((t :inherit default))))
