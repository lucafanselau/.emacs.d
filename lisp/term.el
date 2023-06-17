
(use-package
 vterm

 :init (my/open-map "t" #'my/vterm "s" #'my/run-scripts)

 :config (setq vterm-term-environment-variable "eterm-color")

 (setq vterm-max-scrollback 5000)

 (add-to-list
  'display-buffer-alist
  `("\\*vterm\\*"
    (display-buffer-in-side-window)
    (window-height . 0.4)
    (window-width .0.5)))

 (general-define-key
  :keymaps 'vterm-mode-map "C-c <escape>" #'vterm-send-escape)

 (add-hook
  'vterm-mode-hook (my/setq-locally confirm-kill-processes nil))
 (add-hook 'vterm-mode-hook (my/setq-locally hscroll-margin 0))
 (add-hook
  'vterm-mode-hook (my/turn-off-mode display-line-numbers-mode)))


(use-package
 eterm-256color
 :ensure t
 :config (add-hook 'vterm-mode-hook #'eterm-256color-mode))

(provide 'term)
