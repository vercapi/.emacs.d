;; Load general emacs config

;;; GUI
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; Solarized Color Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

;;; Emacs initialization
(setq inhibit-splash-screen t)
(winner-mode 1) ;; (Restore configuration: C-c <-; Next configuration C-c ->)
(windmove-default-keybindings) ;; Set S-<arrows> to move around the windows (S- <arrow> to move along windows)
(global-linum-mode t) ;; enable lines in gutter
(setq backup-directory-alist '(("." . "~/.saves"))) ;; Save backup files in a dedicated directory
(server-start)

;;; Global settings
(setq user-full-name "Pieter Vercammen")
(setq user-mail-address "pieterv.sorano@gmail.com")

;; Locale settings
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; Editor screen settings
(setq-default indent-tabs-mode nil) ;; don't use tabs
(setq-default tab-width 2) ;; use 2 space tabs
(global-hl-line-mode 1) ;; highlight current line
(show-paren-mode 1) ;; show matching parentheses
(tool-bar-mode -1) ;; no toolbar
(column-number-mode t)
(size-indication-mode) ;; show filesize
(fset 'yes-or-no-p 'y-or-n-p) ;; type y/n not yes/no

;;; Enable Emacs builtin packages
(require 'ido)
(ido-mode t)

(package-initialize)

;;; package.el
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("SC" . "http://joseito.republika.pl/sunrise-commander/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-list '(ace-jump-mode autopair ecb evil goto-chg undo-tree expand-region f dash s flymake-lua flymake-python-pyflakes flymake-easy flymake-yaml flymake-easy goto-chg iy-go-to-char jedi python-environment deferred auto-complete popup epc ctable concurrent deferred lua-mode magit git-rebase-mode git-commit-mode multiple-cursors nurumacs popup projectile pkg-info epl dash s pymacs python-environment deferred s sr-speedbar ssh sunrise-commander undo-tree yaml-mode))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;; CEDET
(load-file "~/.emacs.d/cedet-bzr/trunk/cedet-devel-load.el") 
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
(semantic-mode 1)                        ; Enable semantic

;; load contrib library
(load-file "~/.emacs.d/cedet-bzr/trunk/contrib/cedet-contrib-load.el")


;;; Autopair
(require 'autopair)
(autopair-global-mode)

;;; org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '( (python . t)
     )
 )

(defun close-org-hook ()
 (remove-hook 'kill-buffer-hook 'close-org-hook)
   (if (is-org-file)
       (org-md-export-to-markdown))
   (add-hook 'kill-buffer-hook 'close-org-hook))

(defun is-org-file ()
 (if (and 
      (string-match ".org" (substring (if buffer-file-name buffer-file-name "nilfile") -4))
      (string= (buffer-mode) "org-mode"))
     t))

(add-hook 'kill-buffer-hook 'close-org-hook)

(defun buffer-mode ()
  (with-current-buffer (current-buffer)
    major-mode))

;;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; virtualenv
;; (require 'virtualenvwrapper)
;; (venv-initialize-interactive-shells)
;; (venv-initialize-eshell) 
;; (setq venv-location "~/Documents/projects/")

;;; python-mode
(setq python-version-checked t)
(setenv "PYMACS_PYTHON" "python2")

(defun python-docstring ()
  "Inserts a Python docstring"
  (interactive)
  (python-nav-beginning-of-block)
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

;;; pymacs.el
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

;;; ropemacs.el
(pymacs-load "ropemacs" "rope-")

;;; Python tests
(defun py-tests ()
  (interactive)
  (setq path (projectile-parent (file-name-directory buffer-file-name)))
  (let ((process-environment (cons (concat "PYTHONPATH=" path) process-environment))
        (buffer (get-buffer-create "*Test Results*")))
    (set-buffer buffer)
    (erase-buffer)
    (call-process "python" nil t nil "-m" "unittest" "discover" "-s" (concat path "/tests"))
    (display-buffer buffer))
  (py-test-parse-buffer)
  )

(defun py-test-parse-buffer ()
  (goto-char (point-min)) 
  (setq link-begin (search-forward "\"" nil t))
  (while link-begin
    (setq link-end (search-forward "\""))
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "RET") 'py-test-open-source)
      (add-text-properties link-begin link-end '(mouse-face highlight face bold))
      (put-text-property link-begin link-end 'keymap map))
    (setq link-begin (search-forward "\"" nil t)))
  )

(defun py-test-open-source ()
  (interactive)
  (setq link-start (search-backward "\""))
  (forward-char)
  (setq link-end (search-forward "\""))
  (setq line-nr-pos (search-forward-regexp "Line [0-9]*"))
  (setq line-nr (string-to-number (thing-at-point 'word)))
  (switch-to-buffer (find-file-noselect (buffer-substring (+ link-start 1) (- link-end 1))))
  (print line-nr)
  (let ((current-prefix-arg line-nr))
    (call-interactively 'goto-line)))

;;; Load jedi.el
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)

;;; Load jedi-direx
;; (eval-after-load "python"
;;   (define-key python-mode-map "\C-c t" 'jedi-direx:pop-to-buffer))
;; (add-hook 'jedi-mode-hook 'jedi-direx:setup)

;;; EIN
;;(setq ein:use-auto-complete t)
;;(add-hook 'ein:connect-mode-hook 'ein:jedi-setup) -> WARNING -> Disables CEDET for python

;;; pyflakes
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(defun flymake-show-error ()
      (interactive)
      (let ((err (get-char-property (point) 'help-echo)))
        (when err
          (message err))))

;;; load sr-speedbar
;;(load-file "~/.emacs.d/sr-speedbar.el")
(require 'sr-speedbar)

;;; sqlplus
;;(load-file "~/.emacs.d/sqlplus.el")
;;(require 'sqlplus)
;;; SQLPlus Settings
;;(add-to-list 'exec-path "/cygdrive/c/Oracle/product/11.2.0/dbhome_1/BIN")
;;(setenv "ORACLE_HOME" "/cygdrive/c/Oracle/product/11.2.0/dbhome_1/")

;;; idoc mode
;;(load-file "~/.emacs.d/idoc-mode.el") 

;;; autocomplete.el
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;; undo-tree.el
(global-undo-tree-mode t)
(setq undo-tree-visualizer-relative-timestamps t)
(setq undo-tree-visualizer-timestamps t)

;; Evil
;; We want evil for some functions but we don't want the vi mode enabled
(require 'evil)
(evil-mode 0)

;;; Keymaps Python
(global-set-key (kbd "C-c J") 'semantic-ia-fast-jump)
(global-set-key (kbd "C-c j") 'jedi:goto-definition)
(global-set-key (kbd "C-c d") 'jedi:show-doc)
(global-set-key (kbd "<C-tab>") 'jedi:complete)
(global-set-key (kbd "C-c i") 'flymake-show-error)
(global-set-key (kbd "C-c n") 'senator-next-tag)
(global-set-key (kbd "C-c p") 'senator-previous-tag)
(global-set-key (kbd "C-D") 'python-docstring)

;;; Keymaps general
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-*") 'evil-search-word-forward)
(global-set-key (kbd "C-%") 'evil-search-word-backward)

;;; Moving around
(global-set-key (kbd "C-c f") 'iy-go-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
(global-set-key (kbd "C-c ;") 'iy-go-to-or-up-to-continue)
(global-set-key (kbd "C-c ,") 'iy-go-to-or-up-to-continue-backward)

;;; Selection
(global-set-key (kbd "C-=") 'er/expand-region)

;;; Multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; General settings by emacs configuration
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(py-shell-name "/usr/bin/python2")
 '(python-python-command "python2")
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(py-gnitset-test-runner "runner.py")
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 140 :width normal))))
 '(minimap-font-face ((t (:height 40 :family "DejaVu Sans Mono")))))
