
(use-package
 copilot
 :elpaca
 (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
 :hook (prog-mode . copilot-mode)
 :config (setq copilot-enable-predicates '(meow-insert-mode-p))
 :bind
 (:map
  copilot-completion-map
  ("C-<return>" . 'copilot-accept-completion)
  ("C-TAB" . 'copilot-accept-completion-by-word)
  ("C-<tab>" . 'copilot-accept-completion-by-word)))

(provide 'fwm)
