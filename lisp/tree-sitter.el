;; bundled tree sitter setup
(use-package treesit
:elpaca nil
:init
(setq treesit-extra-load-path '("~/.emacs.d/grammar"))
:mode (
(".*\\.ts\\'" . typescript-ts-mode)
(".*\\.tsx\\'" . tsx-ts-mode)
)
)


(use-package eglot
:elpaca nil
:hook (prog-mode . eglot-ensure)
)




(provide 'tree-sitter)