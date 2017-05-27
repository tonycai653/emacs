;;; This file bootstraps the configuration, which is dvided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-osx)
(require 'init-recentf)
;; If you really prefer ido to ivy, change the comments below. I will
;; likely remove the ido config in due course, though.
;; (require 'init-ido)
(require 'init-ivy)
(require 'init-company)

(require 'init-editing-utils)
;;(require 'init-whitespace)

(require 'init-projectile)
(require 'init-irony)
(require 'init-python-mode)
(require 'init-lisp)
(require 'init-misc)
(require 'init-c-mode)
(require 'init-frame-hooks)
(require 'init-themes)
(require 'init-git)
(require 'init-neotree)
(require 'init-window)
;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )


(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("f5512c02e0a6887e987a816918b7a684d558716262ac7ee2dd0437ab913eaec6" default)))
 '(package-selected-packages
   (quote
    (whole-line-or-region rtags cmake-ide ggtags zenburn-theme yafolding unfill redshank realgud rainbow-mode projectile pip-requirements paredit origami neotree molokai-theme magit macrostep lively ipretty immortal-scratch hl-sexp highlight-quoted highlight-indent-guides highlight-escape-sequences flycheck-package flx evil elpy elisp-slime-nav eldoc-eval diminish counsel company-anaconda column-marker color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized cl-lib-highlight cask-mode auto-compile anti-zenburn-theme aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "#e5786d" :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "color-246"))))
 '(font-lock-comment-face ((t (:foreground "color-246"))))
 '(font-lock-doc-face ((t (:foreground "#95e454"))))
 '(font-lock-function-name-face ((t (:foreground "#88b8f6"))))
 '(font-lock-keyword-face ((t (:foreground "color-173"))))
 '(font-lock-string-face ((t (:foreground "#95e454"))))
 '(font-lock-variable-name-face ((t (:foreground "white"))))
 '(link ((t (:foreground "brightblue" :underline t :weight bold))))
 '(link-visited ((t (:foreground "color-246" :underline t :weight normal)))))
