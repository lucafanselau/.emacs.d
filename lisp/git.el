(use-package seq :ensure t)

(use-package
 compat
 ;; set this to use the gnu version of compat
 :elpaca (:host github :repo "emacs-compat/compat" :files ("*.el"))
 :ensure t)

(elpaca-wait)

(use-package transient)

(use-package
 magit
 :after (transient)
 :init
 (my/meow-define-keys
  'motion
  'magit-status-mode
  '("K" . meow-prev-expand)
  '("J" . meow-next-expand)))

(my/open-map "g" :wk "magit" #'magit-status)

(use-package
 emojify
 :hook (after-init . global-emojify-mode)
 :config
 (when (member "Apple Color Emoji" (font-family-list))
   (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji")
                     nil
                     'prepend))
 (setq emojify-display-style 'unicode)
 (setq emojify-emoji-styles '(unicode)))
(use-package
 gitmoji
 :elpaca
 (:host github :repo "janusvm/emacs-gitmoji" :files ("*.el" "data")))

(provide 'git)
