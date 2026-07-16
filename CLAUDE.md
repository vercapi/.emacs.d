# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a **literate Emacs configuration** built around a single Org file:

- `init.el` — bootstrap only; loads `config.org` via `org-babel-load-file`
- `config.org` — **the sole source of truth** for all configuration and behavior
- `config.el` — generated artifact (gitignored); never edit directly
- `custom/` — local helper libraries loaded explicitly from `config.org` via `load`/`require`
- `snippets/` — yasnippet templates for language-specific editing
- `secrets.el` — gitignored; loaded early in `config.org`; never commit or replicate its contents

## Key conventions

- **Make all changes in `config.org`**, not in any generated or derived file.
- Use `use-package` blocks for all package configuration — it is the dominant pattern throughout.
- New user-defined functions must be namespaced `pve-` or `pve/` (existing convention).
- `config.org` is organized with Org mode hierarchy (`*` / `**` sections by function); place new code under the appropriate existing heading.
- Follow literate style: accompany code blocks with concise Org prose describing intent.
- Prefer existing Emacs packages and built-ins before writing custom Emacs Lisp; keep `custom/` additions minimal and focused.
- Absolute paths (`~/.emacs.d/...`) are intentional — preserve them.
- Package management is entirely within this repo (MELPA + ELPA via `package.el` + `quelpa`); do not use Nix for Emacs packages.

## OS-level dependencies

If a package or feature requires OS-level tooling (system binaries, native libraries, fonts, dictionaries, etc.), **do not install them manually or via Nix imperatively**. Instead, spawn a new agent pointed at `~/nixos/` and instruct it to add the dependency following the conventions in `~/nixos/CLAUDE.md` (edit `config.org` there, tangle, and rebuild).

## Regenerating config.el

After editing `config.org`, tangle to rebuild `config.el`:

```bash
emacs --batch --eval "(progn (require 'org) (require 'ob-tangle) (org-babel-tangle-file \"config.org\"))"
```

There is no automated test suite or CI for this repository.
