;; bundled tree sitter setup
(use-package treesit
:elpaca nil
:init
(setq treesit-extra-load-path '("~/.emacs.d/grammar"))
)

(provide 'tree-sitter)