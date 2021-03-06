(require 'pip-requirements)
(require 'column-marker)
(require 'elpy)
(require 'origami)

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))
;; using elpy
(elpy-enable)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "python3")


;; column marker
(set-face-background 'column-marker-1 "red")
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; use realgud and load it when open python file
(autoload 'realgud:pdb "realgud" "call pdb debugger" t nil)
(global-set-key (kbd "C-C d") 'realgud:pdb)
(setq realgud-safe-mode nil)

;; origmi
(add-hook 'python-mode-hook 'origami-mode)
(define-key origami-mode-map (kbd "C-c f") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-c F") 'origami-recursively-toggle-node)
(define-key origami-mode-map (kbd "C-c T") 'origami-toggle-all-nodes)

(setq python-shell-interpreter "python3")
(setq python-indent-offset 4)

(provide 'init-python-mode)
