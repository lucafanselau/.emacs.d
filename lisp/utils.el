;;; utils.el -*- lexical-binding: t; -*-


(use-package general
  :ensure t
  :config
  (general-auto-unbind-keys)
)

(elpaca-wait)

(general-create-definer my/leader
    ;; :prefix my-leader
    :prefix "SPC")

(my/leader
    "f" '(:ignore t :which-key "file")
    "b" '(:ignore t :which-key "buffer")
    "s" '(:ignore t :which-key "search")
    "o" '(:ignore t :which-key "Open")
    "t" '(:ignore t :which-key "toggle"))

(general-create-definer my/open-map
    :prefix "C-c o"
    :prefix-map 'my/open-map)

(general-create-definer my/search-map
    :prefix "C-c s"
    :prefix-map 'my/search-map)

(general-create-definer my/toggle-map
    :prefix "C-c t"
    :prefix-map 'my/toggle-map)

(provide 'utils)
;;; utils.el ends here
