(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  (setq mouse-wheel-scroll-amount '(8 ((shift) . 8) ((control) . nil)))
  (setq-default default-input-method "MacOSX"))


(provide 'init-osx)

