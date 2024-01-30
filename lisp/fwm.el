
;; coding assistance
(use-package jsonrpc)


(use-package
 copilot
 :after (jsonrpc)
 :elpaca
 (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
 :hook ((prog-mode org-mode) . copilot-mode)
 :config (setq copilot-enable-predicates '(meow-insert-mode-p))
 :bind
 (:map
  copilot-completion-map
  ("C-<return>" . 'copilot-accept-completion)
  ("C-TAB" . 'copilot-accept-completion-by-word)
  ("C-<tab>" . 'copilot-accept-completion-by-word)))


;; writing assistance

(use-package
 eglot-grammarly
 :elpaca (:host github :repo "emacs-grammarly/eglot-grammarly")
 :defer t ; defer package loading
 ;;:hook
 ;; ((text-mode markdown-mode)
 ;;  .
 ;;  (lambda ()
 ;;    (require 'eglot-grammarly)
 ;;    (eglot-ensure)))
 )

(provide 'fwm)
