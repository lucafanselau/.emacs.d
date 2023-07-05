
(use-package
 magit
 :init (my/open-map "g" :wk "magit" #'magit-status)
 (my/meow-define-keys
  'motion
  'magit-status-mode
  '("K" . meow-prev-expand)
  '("J" . meow-next-expand)))

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
