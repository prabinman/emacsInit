;; init.el --- Emacs configuration
;; Author: Prabin Man Shrestha
;; email: shrestha.prabinman@gmail.com
;; Modified Date: February 25, 2017
;; list the repositories containing them

;; INSTALL PACKAGES
;; -----------------------------------------------------------------

(require 'package)

(setq package-archives '(("gnu"."https://elpa.gnu.org/packages/")
			 ("melpa-stable"."https://stable.melpa.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; list the packages you want
(setq package-list '(better-defaults))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)

;; hide the startup message
(setq inhibit-splash-screen t
      initial-scratch-message nil
      ;; initial-major-mode 'ruby-mode
      )

(setq package-list '(better-defaults
                     company-mode
                     solarized-theme
                     cyberpunk-theme
                     paredit
                     rainbow-delimiters
                     flycheck
                     haskell-mode
                     helm
                     helm-projectile
                     helm-ag
                     which-key
                     multiple-cursors
                     ruby-electric
                     web-mode
                     emmet-mode
                     flymake-jslintx
                     elpy
                     py-autopep8))

;; BASIC CUSTOMIZATION
;; ----------------------------------------------------------------------

;; Root edit a file in the same session
(require 'tramp)
(setq tramp-default-method "scp")
(setq recentf-auto-cleanup ':never)
;; Haskell config
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-via-dvips-ps2pdf t)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" default)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(package-selected-packages
   (quote
    (auctex hindent haskell-snippets multiple-cursors which-key howdoi cyberpunk-theme company-php company-tern tern flymake-jslint py-autopep8 elpy emmet-mode web-mode eww-lnum robe company-flx helm company-inf-ruby company flymake-ruby rainbow-delimiters paredit ruby-electric solarized-theme better-defaults))))

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x f") 'helm-find)

;; cycle through buffers with Ctrl-Tab
(global-set-key (kbd "<C-tab>") 'bury-buffer)
(if (display-graphic-p)
    (load-theme 'solarized-dark t)
  (load-theme 'cyberpunk t))
;; (load-theme 'solarized-dark t)
;; Show line numbers
(global-linum-mode)
;; display the current column-number
(setq column-number-mode t)
;; LaTeX mode
;; (require 'LaTeX-mode)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTex-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(require 'tex)
(TeX-global-PDF-mode t)
;; telling emacs to trust all themes for avoiding prompts during each login
(setq custom-safe-themes t)
;; ask "y" or "n" instead of "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

;; avoiding mismatching parenthesis
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'haskell-mode-hook 'paredit-mode)
(add-hook 'haskell-mode-hook 'rainbow-delimiters-mode)
(add-hook 'LaTeX-mode-hook 'paredit-mode)
(add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
(require 'rainbow-delimiters)
(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)
(add-hook 'python-mode-hook 'rainbow-delimiters-mode)
;; Autoclose paired syntax elements like parens, quotes, etc
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(add-hook 'ruby-mode-hook 'robe-mode)

;; company-mode in all buffers
;; (add-to-list 'company-backends 'company-ghc)
(add-hook 'after-init-hook 'global-company-mode t)
;;(add-to-list 'company-backends 'company-ghc)

(with-eval-after-load 'company
  ;; (add-to-list 'company-backends)
  (company-flx-mode +1)
  '(push 'company-robe company-tern company-yasnippet company-backends))

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(require 'which-key
         (which-key-mode))
(which-key-setup-minibuffer)
(setq which-key-idle-delay 2.0)

(require 'haskell-mode)
(add-hook 'haskell-mode-hook #'hindent-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; Add F8 key combination for going to imports block
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
;; Add key combination for interactive haskell-mode
(eval-after-load 'haskell-mode '(progn
                                  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
                                  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
                                  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
                                   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))

(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "blue")
(set-face-background 'mode-line-inactive "light blue")
;; Typography
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150
                    :weight 'normal
                    :width 'normal)

;; WEB CONFIGURATION
;;-------------------------------------------------------------------

(require 'yasnippet)
(yas-global-mode 1)

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; javascript configuration using js-mode and flymake-jslint and tern
(require 'flymake-jslint)
(add-hook 'web-mode-hook 'flymake-jslint-load)
;; (add-hook 'web-mode-hook (lambda () (tern-mode t)))

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)


;; PYTHON CONFIGURATION
;;-------------------------------------------------------------------

(elpy-enable)
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; ignoring:
;; -E501 - Try to make lines fit within --max-line-length characters.
;; -W293 - Remove trailing whitespace on blank line.
;; -W392 - Remove trailing blank lines.
;; -W690 -Fix various deprecated code (via lib2to3)
(require 'py-autopep8)
(setq py-autopep8-options '("--ignore=E501,W293,W391"))
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
