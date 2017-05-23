(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
;; c offset
(setq-default c-basic-offset 4)

(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(cmake-ide-setup)


(provide 'init-c-mode)
