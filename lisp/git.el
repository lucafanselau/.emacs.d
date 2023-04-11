
(use-package
 magit
 :init (my/open-map "g" :wk "magit" #'magit-status)
 (my/meow-define-keys
  'motion
  'magit-status-mode
  '("K" . meow-prev-expand)
  '("J" . meow-next-expand)))

(provide 'git)
