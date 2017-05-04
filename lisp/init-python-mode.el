(require 'pip-requirements)
(require 'anaconda-mode)
(require 'company-anaconda)
(require 'column-marker)
(require 'highlight-indent-guides)
(require 'yafolding)

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

;; set column marker
(set-face-background 'column-marker-1 "red")
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

(add-hook 'python-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

;; yafolding
(add-hook 'python-mode-hook 'yafolding-mode)
(define-key yafolding-mode-map (kbd "<C-S-return>") nil)
(define-key yafolding-mode-map (kbd "<C-M-return>") nil)
(define-key yafolding-mode-map (kbd "<C-return>") nil)
(define-key yafolding-mode-map (kbd "C-c F") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-c f") 'yafolding-toggle-element)

(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "--simple-prompt -i")

(defun python-shell-completion-native-try ()
  "Return non-nil if can trigger native completion"
  (with-eval-after-load 'python
    '(let ((python-shell-completion-native-enable t)
           (python-shell-completion-native-output-timeout python-shell-completion-native-try-output-timeout))
       (python-shell-completion-native-get-completions (get-buffer-process (current-buffer))
                                                       nil "_"))))

(provide 'init-python-mode)
