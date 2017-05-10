;; WAITING: haskell-mode sets tags-table-list globally, breaks tags-completion-at-point-function
;; TODO Default sort order should place [a-z] before punctuation

(require 'company)
(require 'color)
;;(require 'company-quickhelp)

(setq tab-always-indent 'complete)  ;; use 't when company is disabled
(add-to-list 'completion-styles 'initials t)
;; Stop completion-at-point from popping up completion buffers so eagerly
(setq completion-cycle-threshold 5)

(add-hook 'after-init-hook 'global-company-mode)
(after-load 'company
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (setq-default company-backends '((company-capf company-dabbrev-code company-dabbrev))
                company-dabbrev-other-buffers 'all))
(global-set-key (kbd "M-C-/") 'company-complete)


;;(add-hook 'after-init-hook 'company-quickhelp-mode)

(defun sanityinc/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines-mode
    (defvar sanityinc/page-break-lines-on-p nil)
    (make-variable-buffer-local 'sanityinc/page-break-lines-on-p)

    (defun sanityinc/page-break-lines-disable (&rest ignore)
      (when (setq sanityinc/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun sanityinc/page-break-lines-maybe-reenable (&rest ignore)
      (when sanityinc/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'sanityinc/page-break-lines-disable)
    (add-hook 'company-completion-finished-hook 'sanityinc/page-break-lines-maybe-reenable)
    (add-hook 'company-completion-cancelled-hook 'sanityinc/page-break-lines-maybe-reenable)))

(setq company-idle-delay 0.1)
(setq comany-tooltip-limit 10)
(setq company-dabbrev-downcase 0)

;; for emacs with dark background
;;(set-background-color "black")

(progn
  (set-face-attribute 'company-tooltip nil :background "brightblack")
  (set-face-attribute 'company-tooltip-selection nil :background "magenta")
  (set-face-attribute 'company-tooltip-common nil :background nil :foreground "#B58900" :inherit 'company-tooltip)
  (set-face-attribute 'company-tooltip-common-selection nil :background nil :foreground "#B58900" :inherit 'company-tooltip-selection))

(provide 'init-company)
