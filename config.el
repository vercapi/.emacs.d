
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq size-indication-mode t)

(require 'ido)
(ido-mode t)

(setq column-number-mode t)

(custom-set-faces
 '(default ((t (:family "DejaVu Sans Mono for Powerline" :foundry "unknown" :slant normal :weight normal :height 140 :width normal))))
 '(mode-line ((t (:family "DejaVu Sans Mono for Powerline" :foundry "unknown" :slant normal :weight normal :height 140 :width normal)))))

(setq inhibit-splash-screen t)
(global-linum-mode t)
(setq backup-directory-alist '(("." . "~/.saves")))
(server-start)
(setq user-full-name "Pieter Vercammen")
(setq user-mail-address "pieterv.sorano@gmail.com")

(winner-mode 1) 
(windmove-default-keybindings) ;; Set S-<arrows> to move around the windows (S- <arrow> to move along windows)

(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil) ;; don't use tabs
(setq-default tab-width 2) ;; use 2 space tabs
(global-hl-line-mode 1) ;; highlight current line
(show-paren-mode 1) ;; show matching parentheses
(tool-bar-mode -1) ;; no toolbar
(column-number-mode t)
(size-indication-mode) ;; show filesize
(fset 'yes-or-no-p 'y-or-n-p) ;; type y/n not yes/no

;; activate all the packages (in particular autoloads)
(package-initialize)

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("SC" . "http://joseito.republika.pl/sunrise-commander/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-list '(ace-jump-mode ecb goto-chg undo-tree expand-region f dash s flymake-lua flymake-python-pyflakes flymake-easy flymake-yaml flymake-easy goto-chg iy-go-to-char jedi python-environment deferred auto-complete popup epc ctable concurrent deferred lua-mode magit git-rebase-mode git-commit-mode multiple-cursors nurumacs popup projectile pkg-info epl dash s pymacs python-environment deferred s sr-speedbar ssh sunrise-commander undo-tree yaml-mode powerline solarized-theme markdown-mode helm helm-pydoc helm-projectile helm-spotify))

;; refresh package archive
(unless package-archive-contents
  (package-refresh-contents)e)

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load-file "~/.emacs.d/cedet-bzr/trunk/cedet-devel-load.el") 
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
(semantic-mode 1)                        ; Enable semantic

;; load contrib library
(load-file "~/.emacs.d/cedet-bzr/trunk/contrib/cedet-contrib-load.el")

(setq ecb-options-version "2.40")
(setq ecb-tip-of-the-day nil)

(setq org-replace-disputed-keys t)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (sh . t)
   (emacs-lisp . t)
   ))

(setq org-confirm-babel-evaluate nil)

(setq org-babel-python-command "python2")

(require 'helm-config)
(helm-mode 1)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(define-key helm-map (kbd "M-y") 'helm-show-kill-ring)

(load-theme 'solarized-dark t)

(require 'powerline)
(powerline-default-theme)

(setq python-version-checked t)
(setenv "PYMACS_PYTHON" "python2")
(setq python-python-command "python2")
(setq py-shell-name "/usr/bin/python2")
(setq py-python-command "/usr/bin/python2")
(setq python-environment-virtualenv (list "virtualenv2" "--system-site-packages" "--quiet"))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(pymacs-load "ropemacs" "rope-")

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)

(setq jedi:environment-root "two")
(setq jedi:environment-virtualenv
      (append "virtualenv2"
              '("--python" "/usr/bin/python2")))

(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(defun flymake-show-error ()
      "Show error at point"
      (interactive)
      (let ((err (get-char-property (point) 'help-echo)))
        (when err
          (message err))))

(global-set-key (kbd "C-c i") 'flymake-show-error)

(load "~/.emacs.d/custom/py-tests.el")

(load "~/.emacs.d/custom/py-tests.el")

(global-set-key (kbd "C-c J") 'semantic-ia-fast-jump)
(global-set-key (kbd "C-c j") 'jedi:goto-definition)
(global-set-key (kbd "C-c d") 'jedi:show-doc)
(global-set-key (kbd "<C-tab>") 'jedi:complete)
(global-set-key (kbd "C-c n") 'senator-next-tag)
(global-set-key (kbd "C-c p") 'senator-previous-tag)
(global-set-key (kbd "C-D") 'python-docstring)
(global-set-key (kbd "C-c h p") 'helm-pydoc)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'sr-speedbar)

(global-set-key (kbd "C-c f") 'iy-go-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
(global-set-key (kbd "C-c ;") 'iy-go-to-or-up-to-continue)
(global-set-key (kbd "C-c ,") 'iy-go-to-or-up-to-continue-backward)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(global-undo-tree-mode t)
(setq undo-tree-visualizer-relative-timestamps t)
(setq undo-tree-visualizer-timestamps t)

(electric-pair-mode)

(setq show-paren-mode t)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-=") 'er/expand-region)

(load "~/.emacs.d/custom/copy-paste-behavior.el")

(global-set-key (kbd "C-w") 'custom-cut-line-or-region) ; cut
(global-set-key (kbd "M-w") 'custom-copy-line-or-region) ; copy

(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

(define-key helm-map (kbd "C-c h p")  'helm-projechtile)
