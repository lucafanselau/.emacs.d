
(use-package magit
  :init
  (my/open-map
    "g" :wk "magit" #'magit-status
  ))

(provide 'git)
