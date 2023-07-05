(use-package
 tab-bar
 :elpaca nil
 :hook (after-init-hook . tab-bar-mode)
 :init
 (setq
  tab-bar-show 1
  tab-bar-close-button-show nil
  tab-bar-new-tab-choice "*scratch*"
  tab-bar-tab-hints t
  tab-bar-new-button-show nil
  tab-bar-format '(tab-bar-format-tabs-groups tab-bar-separator))

 (general-create-definer
  my/tab-map
  :prefix "C-c TAB"
  :prefix-map 'my/tab-map)

 (my/tab-map
  ""
  '(:ignore t :which-key "Tab")
  "n"
  #'tab-bar-new-tab
  "c"
  #'tab-bar-close-tab
  "o"
  #'tab-bar-close-other-tabs
  "]"
  #'tab-bar-switch-to-next-tab
  "["
  #'tab-bar-switch-to-prev-tab
  "{"
  #'tab-bar-history-back
  "}"
  #'tab-bar-history-forward
  "b"
  #'tab-bar-move-window-to-tab
  ;; move current window to a new tab (break current tab)
  "l"
  #'tab-bar-move-tab ;; move tab to the right
  "h"
  #'tab-bar-move-tab-backward ;; move tab to the left
  "g"
  #'tab-bar-change-tab-group ;; make group
  "TAB"
  #'tab-bar-switch-to-tab))

(use-package
 bufler
 :hook
 ((tab-bar-mode . bufler-tabs-mode) (after-init-hook . bufler-mode))
 :init (my/buffer-map "l" 'bufler))

(require 'uniquify)
(setq
 uniquify-buffer-name-style 'forward
 uniquify-min-dir-content 2)

;; (use-package
;;  project-x
;;  :after project
;;  :config
;;  (setq project-x-save-interval 600) ;Save project state every 10 min
;;  (setq project-x-local-identifier
;;        '("package.json" "mix.exs" "Project.toml" ".project"))
;;  (project-x-mode 1))


(use-package
 project-rootfile
 :after project
 :init
 (add-to-list 'project-find-functions #'project-rootfile-try-detect))

(provide 'workspace)
