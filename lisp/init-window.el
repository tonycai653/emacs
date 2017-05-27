(defun start-shell-horizontal-window ()
  "start a new shell in new buffer in horizontal window"
  (interactive)
  (progn (split-window-horizontally)
         (other-window 1)
         (term (getenv "SHELL"))))


(defun start-shell-vertical-window ()
  "start a new shell in new buffer in  window"
  (interactive)
  (progn (split-window-vertically)
         (other-window 1)
         (term (getenv "SHELL"))))

(define-key ctl-x-4-map (kbd "h") 'start-shell-horizontal-window)
(define-key ctl-x-4-map (kbd "v") 'start-shell-vertical-window)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(provide 'init-window)

