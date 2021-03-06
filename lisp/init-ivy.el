(require 'ivy)
(require 'counsel)
(require 'diminish)
(require 'flx)

(after-load 'ivy
(setq-default ivy-use-virtual-buffers t
	  ivy-count-format ""
	  projectile-completion-system 'ivy
	  ivy-initial-inputs-alist
	  '((counsel-M-x . "^")
	    (man . "^")
	    (woman . "^"))))
;; IDO-style directory navigation
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

(diminish 'ivy-mode)

(add-hook 'after-init-hook
    (lambda ()
      (when (bound-and-true-p ido-ubiquitous-mode)
	(ido-ubiquitous-mode -1))
      (when (bound-and-true-p ido-mode)
	(ido-mode -1))
      (ivy-mode 1)))


(setq-default counsel-mode-override-describe-bindings t)

(after-load 'counsel
  (diminish 'counsel-mode))
(add-hook 'after-init-hook 'counsel-mode)


(provide 'init-ivy)
