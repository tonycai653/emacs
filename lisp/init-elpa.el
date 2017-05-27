;;; Find and load the correct package.el

;; When switching between Emacs 23 and 24, we always use the bundled package.el in Emacs 24
(let ((package-el-site-lisp-dir
       (expand-file-name "site-lisp/package" user-emacs-directory)))
  (when (and (file-directory-p package-el-site-lisp-dir)
             (> emacs-major-version 23))
    (message "Removing local package.el from load-path to avoid shadowing bundled version")
    (setq load-path (remove package-el-site-lisp-dir load-path))))

(require 'package)
(require 'cl)


;;; Standard package repositories
;;(add-to-list 'package-archives '("popkit" . "http://elpa.popkit.org/packages/"))

(when (< emacs-major-version 24)
  ;; Mainly for ruby-mode
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;; Also use Melpa for most packages
(add-to-list 'package-archives `("melpa" . ,(if (< emacs-major-version 24)
                                                "http://melpa.org/packages/"
                                              "https://melpa.org/packages/")))

;; NOTE: In case of MELPA problems, the official mirror URL is
;; https://www.mirrorservice.org/sites/stable.melpa.org/packages/

;;; Fire up package.el

(setq package-enable-at-startup nil)
(package-initialize)

(defvar user-packages
  '(undo-tree
    whole-line-or-region
    neotree
    cmake-ide
    rtags
    company-rtags
    irony
    company-irony
    company-irony-c-headers
    realgud
    zenburn-theme
    column-marker
    origami
    cl
    ivy
    magit
    counsel
    diminish
    flx
    company
    color
    highlight-escape-sequences
    unfill
    projectile
    pip-requirements
    elisp-slime-nav
    lively
    ipretty
    auto-compile
    cl-lib-highlight
    macrostep
    flycheck
    flycheck-package
    cask-mode
    hl-sexp
    immortal-scratch
    aggressive-indent
    redshank
    eldoc-eval
    highlight-quoted
    rainbow-mode
    paredit
    server
    )
  "A list of packages to ensure are installed at launch")

(defun packages-installed-p ()
  "Check if all packages in `user-packages` are installed."
  (every #'package-installed-p user-packages))


(defun install-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package user-packages)
    (add-to-list 'user-packages package))
  (unless (package-installed-p package)
    (package-install package)))


(defun install-packages (packages)
  "Ensure PACKAGES are installed.                                                                                                                       
Missing packages are installed automatically."
  (mapc #'install-package packages))


(defun install-packages-user-packages ()
  "Install all packages listed in `user-packages'."
  (unless (packages-installed-p)
    ;; check for new packages (package versions)                                                                                                        
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the misssing packages                                                                                                                    
    (install-packages user-packages)))
;; run package installation                                                                                                                             
(install-packages-user-packages)


(defun list-foreighn-packages ()
  "Browse third-party packages not bundled with `user-packages'.                                                                                        
Behave similarly to `package-list-packages', but show only the packages that                                                                           are installed and are not in `user-packages'. Useful for removing unwanted packages."
  (interactive)
  (package-show-package-list
   (set-difference package-activated-list user-packages)))

(provide 'init-elpa)
