;; init.el --- Emacs configuration
;; Author: Prabin Man Shrestha
;; email: shrestha.prabinman@gmail.com
;; Modified Date: April 06, 2016

;; INSTALL PACKAGES
;; -------------------------------------------------------------------------

(require 'package)

(add-to-list 'package-archives
             '(("gnu" . "https://gnu.org/packages/")
             ("melpa" . "https://melpa.org/packages/") t)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
     ein
     elpy  ;; add the elpy package
     flycheck  ;; add the flycheck package
     material-theme
     paredit
     py-autopep8  ;; add the autopep8 package
     rainbow-delimiters  ;; add the rainbow-delimiters
     web-mode  ;; add the web-mode package
     emmet-mode  ;; add the emmet-mode/ zen-coding package
     switch-window  ;; add the switch-window package
     ))


(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
            myPackages)



;; BASIC CUSTOMIZATION
;; --------------------------------------------------------------------------

(setq inhibit-startup-message t)  ;; hide the startup message
(load-theme 'material t)  ;; load material theme
(global-linum-mode t)  ;; enable line numbers globally
(setq column-number-mode t)  ;; display the current column-number
;; complete anything i.e. company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
;; activate company-quickhelp-mode
(company-quickhelp-mode 1)
(setq company-quickhelp-delay nil)  ;; delay automatic company-quickhelp
(eval-after-load 'company
                 '(define-key company-active-map (kbd "M-h") #'comapny-quickhelp-manual-begin))

(fset 'yes-or-no-p 'y-or-n-p)  ;; ask "y" or "n" instead of "yes" or "no"
(setq custom-safe-themes t)  ;; telling emacs to trust all themes for  avoiding prompts during each login
(define-key global-map (kbd "RET") 'newline-and-indent)  ;; enable newline and indent on RET
;; switch-window configuration overriding default configuration
(global-set-key (kbd "C-x o") 'switch-window)
;; avoiding mismatching parenthesis
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(show-paren-mode 1)
(electric-pair-mode 1)


;; WEB CONFIGURATION
;; --------------------------------------------------------------------------

(require 'yasnippet)
(yas-global-mode 1)  ;; yasnippet mode enable

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

;; javascript configuraton using js-mode and flymake-jslint
(require 'flymake-jslint)
(add-hook 'web-mode-hook 'flymake-jslint-load)

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)  ;; enable emmet-mode/ zen-coding
(add-hook 'css-mode-hook 'emmet-mode)

;; PYTHON CONFIGURATION
;; -------------------------------------------------------------------------

(elpy-enable)
; (elpy-use-ipython)

;; enable rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'python-mode-hook 'rainbow-delimiters-mode)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; ignoring:
;; -E501 - Try to make lines fit within --max-line-length characters.
;; -W293 - Remove trailing whitespace on blank line.
;; -W392 - Remove trailing blank lines.
;; -W690 - Fix various deprecated code (via lib2to3)
(require 'py-autopep8)
(setq py-autopep8-options '("--ignore=E501,W293,W391"))
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; init.el ends here
