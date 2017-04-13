(require 'pip-requirements)
(require 'anaconda-mode)
(require 'company-anaconda)


(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))


(after-load 'python
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(after-load 'company
  (add-hook 'python-mode-hook
            (lambda () (sanityinc/local-push-company-backend 'company-anaconda))))


(provide 'init-python-mode)
