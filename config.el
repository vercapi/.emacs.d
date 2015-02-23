
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-splash-screen t) ;; Remove splas screen
(global-linum-mode t) ;; enable lines in gutter
(setq backup-directory-alist '(("." . "~/.saves"))) ;; Save backup files in a dedicated directory
(server-start) ;; Startup emacs server

(winner-mode 1) 
(windmove-default-keybindings) ;; Set S-<arrows> to move around the windows (S- <arrow> to move along windows)

(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)
