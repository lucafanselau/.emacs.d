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
  'consult-ripgrep
  ":"
  'execute-extended-command)
 :config
 (setq project-rootfile-list
       (list "package.json" "CMakeLists.txt" "Pipfile" ".project")))


;; File map
(general-create-definer
 my/file-map
 :prefix "C-c f"
 :prefix-map 'my/file-map)

(general-create-definer
 my/notes-map
 :prefix "C-c n"
 :prefix-map 'my/notes-map)

(my/file-map
 "s" 'save-buffer "f" 'project-find-file

 ;; TODO Do more of this
 "h" 'consult-recent-file "r" 'rename-visited-file)

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
 'winner-redo
 "w"
 'other-window
 "m"
 'switch-to-minibuffer)

(use-package
 ace-window
 :init (setq aw-dispatch-always t) (my/window-map "W" 'ace-window))

;; Frame map
(general-create-definer
 my/frame-map
 :prefix "C-c F"
 :prefix-map 'my/frame-map)


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

(use-package
 avy-zap
 :init (meow-define-keys 'normal '("Z" . avy-zap-to-char))

 (my/search-map "z" 'avy-zap-to-char))


(provide 'manager)
