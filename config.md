<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. General Emacs Settings</a>
<ul>
<li><a href="#sec-1-1">1.1. UI configuration</a></li>
<li><a href="#sec-1-2">1.2. Emacs Startup</a></li>
</ul>
</li>
</ul>
</div>
</div>


# General Emacs Settings<a id="sec-1" name="sec-1"></a>

## UI configuration<a id="sec-1-1" name="sec-1-1"></a>

Removing menu bar, toolbar and scollbar

    (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
    (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
    (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

## Emacs Startup<a id="sec-1-2" name="sec-1-2"></a>

    (setq inhibit-splash-screen t)
    (winner-mode 1) ;; (Restore configuration: C-c <-; Next configuration C-c ->)
    (windmove-default-keybindings) ;; Set S-<arrows> to move around the windows (S- <arrow> to move along windows)
    (global-linum-mode t) ;; enable lines in gutter
    (setq backup-directory-alist '(("." . "~/.saves"))) ;; Save backup files in a dedicated directory
    (server-start)