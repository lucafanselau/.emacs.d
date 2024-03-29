;;; utils.el -*- lexical-binding: t; -*-


;; realy basic dependencies

(use-package general :ensure t :config (general-auto-unbind-keys))

(use-package dash :ensure t)
(use-package f :ensure t :demand t)
(use-package deferred :demand t)

(use-package
 ansi-color
 :ensure t
 :elpaca nil
 :hook (compilation-filter . ansi-color-compilation-filter))

(elpaca-wait)

(general-create-definer
 my/leader
 ;; :prefix my-leader
 :prefix "SPC")

(my/leader
 "f"
 '(:ignore t :which-key "file")
 "b"
 '(:ignore t :which-key "buffer")
 "s"
 '(:ignore t :which-key "search")
 "o"
 '(:ignore t :which-key "Open")
 "t"
 '(:ignore t :which-key "toggle"))

(general-create-definer
 my/open-map
 :prefix "C-c o"
 :prefix-map 'my/open-map)

(general-create-definer
 my/code-map
 :prefix "C-c c"
 :prefix-map 'my/code-map)

(general-create-definer
 my/search-map
 :prefix "C-c s"
 :prefix-map 'my/search-map)


(general-create-definer
 my/toggle-map
 :prefix "C-c t"
 :prefix-map 'my/toggle-map)

(general-create-definer
 my/buffer-map
 :prefix "C-c b"
 :prefix-map 'my/buffer-map)

(my/buffer-map
 "r" 'revert-buffer "k" 'kill-this-buffer "K" 'kill-buffer)

(my/toggle-map "w" 'toggle-truncate-lines)

(provide 'utils)
;;; utils.el ends here
