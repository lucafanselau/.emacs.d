
(use-package atom-one-dark-theme
:ensure t
)

(use-package smart-mode-line-atom-one-dark-theme
 :ensure t)
(use-package smart-mode-line
:ensure t
:defer 0.2
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'atom-one-dark)
  (message "Hello")
  :config
  (sml/setup))

(elpaca-wait)

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'tango t))
    ('dark (load-theme 'atom-one-dark t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(provide 'theme)