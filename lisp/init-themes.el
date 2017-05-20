;; If you\ don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(zenburn))

;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(defun custom-zenburn ()
  "customize zenburn font lock face"
  (zenburn-with-color-variables
    (custom-theme-set-faces
     'zenburn
     `(font-lock-keyword-face ((t (:foreground "#88b8f6"))))
     `(font-lock-function-name-face ((t (:foreground "#cae982"))))
     `(font-lock-string-face ((t (:foreground "#95e454"))))
     `(font-lock-type-face ((t (:foreground "##d4d987")))))))

(defun load-zenburn-theme ()
  (progn
    (reapply-themes)
    (custom-zenburn)))

(add-hook 'after-init-hook 'load-zenburn-theme)

(provide 'init-themes)
