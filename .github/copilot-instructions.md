# Copilot instructions for this repository

## Build, test, and lint commands

- There is no repository-level build/lint/test automation configured (no Makefile/Cask/Eask/CI workflow in tracked files).
- There is no automated test suite for this repository, so there is no single-test command for repo code.
- Regenerate tangled Emacs Lisp from the literate config:
  - `emacs --batch --eval "(progn (require 'org) (require 'ob-tangle) (org-babel-tangle-file \"config.org\"))"`

## High-level architecture

- This is a literate Emacs configuration. `init.el` is a small bootstrap that calls:
  - `(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))`
- `config.org` is the authoritative source of configuration and custom behavior.
- `config.el` is a generated artifact from `config.org` and is gitignored; do not treat it as source-of-truth.
- `custom/` contains local helper libraries used by the config (for example bracket navigation, copy/paste helpers, utilities, and ad-hoc tooling).
- `snippets/` contains yasnippet templates for language-specific editing workflows.

## Key conventions in this codebase

- **Edit only the Org source of truth**: make configuration changes in `config.org` (the literate Org file) and generate from there. Do not hand-edit generated `config.el`.
- Keep package setup in `use-package` blocks; this is the dominant configuration pattern throughout the file.
- Local helper code lives in `custom/`, with files loaded explicitly (`load`/`require`) from `config.org`.
- Secrets are expected in `~/.emacs.d/secrets.el` (gitignored) and loaded early; do not commit secrets or replace secret-backed variables with literals.
- Many paths are intentionally absolute `~/.emacs.d/...`; preserve this style unless a broader path-normalization refactor is requested.
- Existing custom functions are mostly namespaced with `pve-` / `pve/`; follow that naming pattern for new user-defined helpers.
- Keep `config.org` structured functionally with proper Org mode hierarchy (`*` sections, `**` subsections, etc.), placing related behavior under the appropriate existing functional heading.
- Follow literate development style: when adding or changing code blocks, also add concise explanatory Org prose so intent and behavior are documented in surrounding text.
- Prefer existing Emacs packages and built-in capabilities before introducing custom Emacs Lisp.
- Keep custom code minimal and focused; add new helpers only when package configuration cannot express the behavior.
- Follow Emacs Lisp best practices used in this repo (clear docstrings, idiomatic naming, and integration via hooks/keymaps/use-package instead of ad-hoc one-off patterns).
