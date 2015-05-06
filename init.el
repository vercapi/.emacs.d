(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(jedi:install-python-jedi-dev-command
   (quote
    ("pip2" "install" "--upgrade" "git+https://github.com/davidhalter/jedi.git@dev#egg=jedi"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono for Powerline" :foundry "unknown" :slant normal :weight normal :height 140 :width normal))))
 '(minimap-font-face ((t (:height 40 :family "DejaVu Sans Mono"))))
 '(mode-line ((t (:family "DejaVu Sans Mono for Powerline" :foundry "unknown" :slant normal :weight normal :height 140 :width normal)))))
