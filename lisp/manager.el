;; everything that has to do with the windows, buffers, frames and projects


(use-package
 project
 :elpaca nil
 :init (general-define-key "C-c p" project-prefix-map)
 (general-define-key
  :prefix
  "C-c"
  "SPC"
  'project-find-file
  ","
  'consult-project-buffer
  "<"
  'consult-buffer
  "."
  'find-file
  "/"
  'consult-grep))


;; File map
(general-create-definer
 my/file-map
 :prefix "C-c f"
 :prefix-map 'my/file-map)

(my/file-map
 "s" 'save-buffer "f" 'project-find-file
 ;; TODO Do more of this
 )

;; Window map
(general-create-definer
 my/window-map
 :prefix "C-c w"
 :prefix-map 'my/window-map)

(my/window-map
 "l"
 'split-window-right
 "j"
 'split-window-below
 "o"
 'delete-other-windows
 "b"
 'balance-windows
 "u"
 'winner-undo
 "r"
 'winner-redo)

(use-package
 ace-window
 :init (setq aw-dispatch-always t) (my/window-map "w" 'ace-window))

;; Quit map

(general-create-definer
 my/quit-map
 :prefix "C-c q"
 :prefix-map 'my/quit-map)

(my/quit-map
 "q"
 'save-buffers-kill-emacs
 "Q"
 'kill-emacs
 "r"
 'restart-emacs
 "w"
 'delete-window
 "f"
 'delete-frame)


;; Open map
(my/open-map "f" 'make-frame)

;; searching

(use-package
 avy
 :init
 (my/search-map
  "/" 'avy-goto-char-timer "f" 'avy-goto-char "s" 'avy-goto-char-2))

(use-package avy-zap :init (my/search-map "z" 'avy-zap-to-char))


(provide 'manager)
