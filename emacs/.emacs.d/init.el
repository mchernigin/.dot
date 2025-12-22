;;; init.el --- hi there -*- lexical-binding: t; -*-

;;; Commentary:
;; @mchernigin config based on Emacs-Kick

;;; Code:

;;; Optimize it a little
(setq gc-cons-threshold #x40000000) ;; GC less often
(setq read-process-output-max (* 1024 1024 4)) ;; Read in 4MB chunks instead of 4KB

;;; Setup straight pacakge manager instead of built-in one
(setq package-enable-at-startup nil) ;; Disables the default package manager
(setq straight-check-for-modifications nil)
(defvar bootstrap-version)
(let ((bootstrap-file
	   (expand-file-name
		"straight/repos/straight.el/bootstrap.el"
		(or (bound-and-true-p straight-base-dir)
			user-emacs-directory)))
	  (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
	(with-current-buffer
		(url-retrieve-synchronously
		 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
		 'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package '(project :type built-in))
(straight-use-package 'use-package)

;;; Built-in packages
(require 'package) ;; Load functions to operate on packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Emacs itself as a package
(use-package emacs
  :ensure nil
  :custom
  ;; (auto-save-default nil)
  (tab-width 4)
  (treesit-font-lock-level 2)
  (truncate-lines t) ;; Disable line wrap
  (use-dialog-box nil) ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t) ;; y instead of yes

  :hook
  (prog-mode . display-fill-column-indicator-mode)

  :config
  (set-face-attribute 'default nil :family "Iosevka Nerd Font"  :height 130)
  (when (eq system-type 'darwin)
	(setq mac-command-modifier 'meta)
	(set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 200)
	(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
	(setq ring-bell-function 'ignore))
  (set-fill-column 100)

  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t)

  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)

  :init
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (when scroll-bar-mode (scroll-bar-mode -1))
  (global-hl-line-mode -1)
  (global-auto-revert-mode 1)
  (recentf-mode 1)
  (savehist-mode 1)
  (save-place-mode 1)
  (winner-mode 1)
  (xterm-mouse-mode 1)
  (file-name-shadow-mode 1)
  (modify-coding-system-alist 'file "" 'utf-8))

;;; Window rules
(use-package window
  :ensure nil
  :custom
  (display-buffer-alist
   '(("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|[Hh]elp\\|Messages\\|Bookmark List\\|Ibuffer\\|Occur\\|eldoc.*\\)\\*"
	  (display-buffer-in-side-window)
	  (window-height . 0.25)
	  (side . bottom)
	  (slot . 0))

	 ;; Example configuration for the LSP help buffer,
	 ;; keeps it always on bottom using 25% of the available space:
	 ("\\*\\(lsp-help\\)\\*"
	  (display-buffer-in-side-window)
	  (window-height . 0.25)
	  (side . bottom)
	  (slot . 0))

	 ;; Configuration for displaying various diagnostic buffers on
	 ;; bottom 25%:
	 ("\\*\\(Flymake diagnostics\\|xref\\|ivy\\|Swiper\\|Completions\\)"
	  (display-buffer-in-side-window)
	  (window-height . 0.25)
	  (side . bottom)
	  (slot . 1)))))

(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-lah --group-directories-first")
  (dired-dwim-target t)
  (dired-guess-shell-alist-user
   '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open" "open")
	 ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open" "open")
	 (".*" "open" "xdg-open")))
  (dired-kill-when-opening-new-dired-buffer t)
  :config
  (when (eq system-type 'darwin)
	(let ((gls (executable-find "gls"))) ;; have to `brew install coreutils` on MacOS for GNU ls
	  (when gls
		(setq insert-directory-program gls)))))

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil)
  (setq search-whitespace-regexp ".*?")
  :bind (("C-s" . isearch-forward)
		 ("C-r" . isearch-backward)))

(use-package smerge-mode
  :ensure nil
  :defer t
  :bind (:map smerge-mode-map
			  ("C-c ^ u" . smerge-keep-upper)
			  ("C-c ^ l" . smerge-keep-lower)
			  ("C-c ^ n" . smerge-next)
			  ("C-c ^ p" . smerge-previous)))

(use-package eldoc
  :ensure nil
  :config
  (setq eldoc-idle-delay 0)
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eldoc-echo-area-display-truncation-message nil)
  :init
  (global-eldoc-mode))

(use-package eldoc-box
  :ensure t
  :straight t
  :defer t)

(use-package flymake
  :ensure nil
  :defer t
  ;; :hook (prog-mode . flymake-mode)
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
	 (note "»" compilation-info))))

(use-package org
  :ensure nil
  :defer t)

(use-package which-key
  :ensure nil
  :defer t
  :hook
  (after-init . which-key-mode))

(use-package vertico
  :ensure t
  :straight t
  :hook
  (after-init . vertico-mode)
  :custom
  (vertico-count 10)
  (vertico-resize nil)
  (vertico-cycle nil)
  :config
  ;; Reference: https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
			  (lambda (orig cand prefix suffix index _start)
				(setq cand (funcall orig cand prefix suffix index _start))
				(concat
				 (if (= vertico--index index)
					 (propertize "» " 'face '(:foreground "#80adf0" :weight bold))
				   "  ")
				 cand))))


;; Orderless enhances completion in Emacs by allowing flexible pattern matching.
;; It works seamlessly with Vertico, enabling you to use partial strings and
;; regular expressions to find files, buffers, and commands more efficiently.
;; This combination provides a powerful and customizable completion experience.
(use-package orderless
  :ensure t
  :straight t
  :defer t
  :after vertico
  :init
  (setq completion-styles '(orderless basic)
		completion-category-defaults nil
		completion-category-overrides '((file (styles partial-completion)))))

;;; Marginalia
;; Marginalia enhances the completion experience in Emacs by adding
;; additional context to the completion candidates. This includes
;; helpful annotations such as documentation and other relevant
;; information, making it easier to choose the right option.
(use-package marginalia
  :ensure t
  :straight t
  :hook
  (after-init . marginalia-mode))

;;; Consult
;; Consult provides powerful completion and narrowing commands for Emacs.
;; It integrates well with other completion frameworks like Vertico, enabling
;; features like previews and enhanced register management. It's useful for
;; navigating buffers, files, and xrefs with ease.
(use-package consult
  :ensure t
  :straight t
  :defer t
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
		xref-show-definitions-function #'consult-xref))

;; Embark provides a powerful contextual action menu for Emacs, allowing
;; you to perform various operations on completion candidates and other items.
;; It extends the capabilities of completion frameworks by offering direct
;; actions on the candidates.
;; Just `<leader> .' over any text, explore it :)
(use-package embark
  :ensure t
  :straight t
  :defer t)

;; Embark-Consult provides a bridge between Embark and Consult, ensuring
;; that Consult commands, like previews, are available when using Embark.
(use-package embark-consult
  :ensure t
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package treesit-auto
  :ensure t
  :straight t
  :commands (treesit-auto-install-all treesit-auto-install)
  :custom hiding (treesit-auto-install 'prompt))

;; treesit-auto should do that instead of me, but is slow as fuck
(dolist (mapping '((rust-ts-mode       . "\\.rs\\'")
				   (json-ts-mode       . "\\.json\\'")
				   (python-ts-mode     . "\\.py\\'")
				   (typescript-ts-mode . "\\.ts\\'")
				   (tsx-ts-mode        . "\\.tsx\\'")
				   (js-ts-mode         . "\\.jsx?\\'")
				   (toml-ts-mode       . "\\.toml\\'")
				   (json-ts-mode       . "\\.json\\'")
				   (yaml-ts-mode       . "\\.ya?ml\\'")))
  (add-to-list 'auto-mode-alist (cons (cdr mapping) (car mapping))))

(use-package markdown-mode
  :defer t
  :straight t
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode) ;; Use GitHub flavour of Markdown
  :init (setq markdown-command "multimarkdown"))

(use-package corfu
  :ensure t
  :straight t
  :defer t
  :custom
  (corfu-auto t)                        ;; Only completes when hitting TAB
  ;; (corfu-auto-delay 0)                ;; Delay before popup (enable if corfu-auto is t)
  (corfu-auto-prefix 1)                  ;; Trigger completion after typing 1 character
  (corfu-quit-no-match t)                ;; Quit popup if no match
  (corfu-scroll-margin 5)                ;; Margin when scrolling completions
  (corfu-max-width 50)                   ;; Maximum width of completion popup
  (corfu-min-width 50)                   ;; Minimum width of completion popup
  (corfu-popupinfo-delay 0.5)            ;; Delay before showing documentation popup
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode t))

(use-package eglot
  :ensure t
  :hook
  ((rust-ts-mode . eglot-ensure)
   (rust-ts-mode . (lambda ()
					 (add-hook 'before-save-hook 'eglot-format-buffer nil t))))
  :config
  (setq eglot-sync-connect nil))

(use-package diff-hl
  :defer t
  :straight t
  :ensure t
  :hook
  ((dired-mode . diff-hl-dired-mode)
   (magit-pre-refresh . diff-hl-magit-pre-refresh)
   (magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  :config
  (diff-hl-margin-mode)
  :custom
  (diff-hl-side 'left)
  (diff-hl-margin-symbols-alist '((insert . "┃")
								  (delete . "-")
								  (change . "┃")
								  (unknown . "┆")
								  (ignored . "i")))
  :config
  (diff-hl-margin-mode))

(use-package magit
  :ensure t
  :straight t
  :defer t)

(use-package indent-guide
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-char "│"))

;; The `add-node-modules-path' package ensures that Emacs uses the local
;; `node_modules/.bin' for a project rather than globally installed binaries.
;; This is essential in JavaScript/TypeScript projects where different versions
;; of tools like `eslint' and `typescript-language-server' might be needed
;; per project.
(use-package add-node-modules-path
  :ensure t
  :straight t
  :defer t
  :custom
  ;; Makes sure you are using the local bin for your
  ;; node project. Local eslint, typescript server...
  (eval-after-load 'typescript-ts-mode
	'(add-hook 'typescript-ts-mode-hook #'add-node-modules-path))
  (eval-after-load 'tsx-ts-mode
	'(add-hook 'tsx-ts-mode-hook #'add-node-modules-path))
  (eval-after-load 'typescriptreact-mode
	'(add-hook 'typescriptreact-mode-hook #'add-node-modules-path))
  (eval-after-load 'js-mode
	'(add-hook 'js-mode-hook #'add-node-modules-path)))

(use-package evil
  :ensure t
  :straight t
  :defer t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-want-integration t)      ;; Integrate `evil' with other Emacs features (optional as it's true by default).
  (setq evil-want-keybinding nil)     ;; Disable default keybinding to set custom ones.
  (setq evil-want-C-u-scroll t)       ;; Makes C-u scroll
  (setq evil-want-C-u-delete t)       ;; Makes C-u delete on insert mode
  :config
  (evil-set-undo-system 'undo-tree)   ;; Uses the undo-tree package as the default undo system

  ;; Set the leader key to space for easier access to custom commands. (setq evil-want-leader t)
  (setq evil-leader/in-all-states t)  ;; Make the leader key available in all states.
  (setq evil-want-fine-undo t)        ;; Evil uses finer grain undoing steps

  ;; Define the leader key as Space
  (evil-set-leader '(normal visual) (kbd "SPC"))

  ;; Jump by char
  (evil-define-key '(normal motion) 'global (kbd "S") 'avy-goto-char-2)
  (evil-define-key '(normal motion) 'global (kbd "s") 'avy-goto-char-timer)

  ;; Keybindings for searching and finding files.
  (evil-define-key 'normal 'global (kbd "<leader> s f") 'consult-find)
  (evil-define-key 'normal 'global (kbd "<leader> s g") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s G") 'consult-git-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s r") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader> s h") 'consult-info)
  (evil-define-key 'normal 'global (kbd "<leader> /") 'consult-line)

  ;; Flymake navigation
  (evil-define-key 'normal 'global (kbd "<leader> x x") 'consult-flymake)
  (evil-define-key 'normal 'global (kbd "] d") 'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "[ d") 'flymake-goto-prev-error)

  ;; Dired commands for file management
  (evil-define-key 'normal 'global (kbd "<leader> x d") 'dired)
  (evil-define-key 'normal 'global (kbd "-") 'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader> x f") 'find-file)

  ;; Diff-HL navigation for version control
  (evil-define-key 'normal 'global (kbd "] c") 'diff-hl-next-hunk) ;; Next diff hunk
  (evil-define-key 'normal 'global (kbd "[ c") 'diff-hl-previous-hunk) ;; Previous diff hunk

  ;; NeoTree command for file exploration
  (evil-define-key 'normal 'global (kbd "<leader> e e") 'neotree-toggle)
  (evil-define-key 'normal 'global (kbd "<leader> e d") 'dired-jump)

  ;; Magit keybindings for Git integration
  (evil-define-key 'normal 'global (kbd "<leader> g g") 'magit-status)      ;; Open Magit status
  (evil-define-key 'normal 'global (kbd "<leader> g l") 'magit-log-current) ;; Show current log
  (evil-define-key 'normal 'global (kbd "<leader> g d") 'magit-diff-buffer-file) ;; Show diff for the current file
  (evil-define-key 'normal 'global (kbd "<leader> g D") 'diff-hl-show-hunk) ;; Show diff for a hunk
  (evil-define-key 'normal 'global (kbd "<leader> g b") 'vc-annotate)       ;; Annotate buffer with version control info

  ;; Buffer management keybindings
  (evil-define-key 'normal 'global (kbd "] b") 'switch-to-next-buffer) ;; Switch to next buffer
  (evil-define-key 'normal 'global (kbd "[ b") 'switch-to-prev-buffer) ;; Switch to previous buffer
  (evil-define-key 'normal 'global (kbd "<leader> b i") 'consult-buffer) ;; Open consult buffer list
  (evil-define-key 'normal 'global (kbd "<leader> b b") 'ibuffer) ;; Open Ibuffer
  (evil-define-key 'normal 'global (kbd "<leader> b d") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b k") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b x") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer) ;; Save buffer
  (evil-define-key 'normal 'global (kbd "<leader> b l") 'consult-buffer) ;; Consult buffer
  (evil-define-key 'normal 'global (kbd "<leader> SPC") 'consult-buffer) ;; Consult buffer

  ;; Project management keybindings
  (evil-define-key 'normal 'global (kbd "<leader> p b") 'consult-project-buffer) ;; Consult project buffer
  (evil-define-key 'normal 'global (kbd "<leader> p p") 'project-switch-project) ;; Switch project
  (evil-define-key 'normal 'global (kbd "<leader> p f") 'project-find-file) ;; Find file in project
  (evil-define-key 'normal 'global (kbd "<leader> p g") 'project-find-regexp) ;; Find regexp in project
  (evil-define-key 'normal 'global (kbd "<leader> p k") 'project-kill-buffers) ;; Kill project buffers
  (evil-define-key 'normal 'global (kbd "<leader> p D") 'project-dired) ;; Dired for project

  ;; Yank from kill ring
  ;; (evil-define-key 'normal 'global (kbd "P") 'consult-yank-from-kill-ring)
  (evil-define-key 'normal 'global (kbd "<leader> P") 'consult-yank-from-kill-ring)

  ;; Embark actions for contextual commands
  (evil-define-key 'normal 'global (kbd "<leader> .") 'embark-act)

  ;; Undo tree visualization
  (evil-define-key 'normal 'global (kbd "<leader> u") 'undo-tree-visualize)

  ;; Help keybindings
  (evil-define-key 'normal 'global (kbd "<leader> h m") 'describe-mode) ;; Describe current mode
  (evil-define-key 'normal 'global (kbd "<leader> h f") 'describe-function) ;; Describe function
  (evil-define-key 'normal 'global (kbd "<leader> h v") 'describe-variable) ;; Describe variable
  (evil-define-key 'normal 'global (kbd "<leader> h k") 'describe-key) ;; Describe key

  ;; Tab navigation
  (evil-define-key 'normal 'global (kbd "] t") 'tab-next) ;; Go to next tab
  (evil-define-key 'normal 'global (kbd "[ t") 'tab-previous) ;; Go to previous tab

  (defun ek/lsp-describe-and-jump ()
	"Show hover documentation and jump to *lsp-help* buffer."
	(interactive)
	(lsp-describe-thing-at-point)
	(let ((help-buffer "*lsp-help*"))
	  (when (get-buffer help-buffer)
		(switch-to-buffer-other-window help-buffer))))

  ;; Emacs 31 finaly brings us support for 'floating windows' (a.k.a. "child frames")
  ;; to terminal Emacs. If you're still using 30, docs will be shown in a buffer at the
  ;; inferior part of your frame.
  (evil-define-key 'normal 'global (kbd "K")
	(if (>= emacs-major-version 31)
		#'eldoc-box-help-at-point
		#'ek/lsp-describe-and-jump))

  ;; Commenting functionality for single and multiple lines
  (evil-define-key 'normal 'global (kbd "gcc")
				   (lambda ()
					 (interactive)
					 (if (not (use-region-p))
						 (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

  (evil-define-key 'visual 'global (kbd "gc")
				   (lambda ()
					 (interactive)
					 (if (use-region-p)
						 (comment-or-uncomment-region (region-beginning) (region-end)))))
  (evil-mode 1))

(use-package evil-collection
  :defer t
  :straight t
  :ensure t
  :custom
  (evil-collection-want-find-usages-bindings t)
  :hook
  (evil-mode . evil-collection-init))

(use-package evil-surround
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-surround-mode 1))

(use-package evil-matchit
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-matchit-mode 1))

(use-package avy
  :ensure t
  :straight t
  :custom
  (avy-timeout-seconds 0.3)
  (avy-style 'pre)
  (avy-all-windows t)
  (avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?q ?w ?e ?r ?u ?i ?o ?p)))

(use-package undo-tree
  :defer t
  :ensure t
  :straight t
  :hook
  (after-init . global-undo-tree-mode)
  :init
  (setq undo-tree-visualizer-timestamps t
		undo-tree-visualizer-diff t
		undo-limit 800000
		undo-strong-limit 12000000
		undo-outer-limit 120000000)
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache/undo"))))

(use-package rainbow-delimiters
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package dotenv-mode
  :defer t
  :straight t
  :ensure t
  :config)

(use-package doom-modeline
  :ensure t
  :straight t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-project-detection 'project)
  (doom-modeline-buffer-name t)
  (doom-modeline-vcs-max-length 25)
  :config
  (setq doom-modeline-icon nil)
  :hook
  (after-init . doom-modeline-mode))

(use-package neotree
  :ensure t
  :straight t
  :custom
  (neo-show-hidden-files t)
  (neo-vc-integration '(face char))
  :defer t)

;;; Themes

;; (use-package gruber-darker-theme
;;   :ensure t
;;   :straight t
;;   :config
;;   (load-theme 'gruber-darker :no-confirm))

(use-package flexoki-themes
  :ensure t
  :straight t
  :config
  (load-theme 'flexoki-themes-dark :no-confirm))

;; (use-package catppuccin-theme
;;   :ensure t
;;   :straight t
;;   :config
;;   (setq catppuccin-flavor 'mocha)
;;   (load-theme 'catppuccin :no-confirm))

;; Enable colors in compilation mode
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;;; UTILITARY FUNCTION TO INSTALL EMACS-KICK
(defun ek/first-install ()
  "Install tree-sitter grammars and compile packages on first run..."
  (interactive)
  (switch-to-buffer "*Messages*")
  (message ">>> All required packages installed.")
  (message ">>> Configuring Emacs-Kick...")
  (message ">>> Configuring Tree Sitter parsers...")
  (require 'treesit-auto)
  (treesit-auto-install-all)
  (message ">>> Emacs-Kick installed! Press any key to close the installer and open Emacs normally. First boot will compile some extra stuff :)")
  (read-key)
  (kill-emacs))

(provide 'init)
;;; init.el ends here
