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

;; origmi
(add-hook 'python-mode-hook 'origami-mode)
(define-key origami-mode-map (kbd "C-c f") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-c F") 'origami-recursively-toggle-node)
(define-key origami-mode-map (kbd "C-c T") 'origami-toggle-all-nodes)

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
