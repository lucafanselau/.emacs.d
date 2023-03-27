;; everything that has to do with the windows, buffers, frames and projects


(use-package project
:elpaca nil
:init
(general-define-key
"C-c p" project-prefix-map)

)

(provide 'manager)