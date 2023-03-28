
(set-display-table-slot standard-display-table 'truncation 32)
(set-display-table-slot standard-display-table 'wrap 32)

;; by default when a long line is truncated, emacs displays
;; a "$" sign at the border of window, which is ugly,
;; replace "$" with " "
;; see discussion here: URL `https://emacs.stackexchange.com/questions/54817/remove-dollar-sign-at-beginning-of-line'

;; set default font
(add-to-list 'default-frame-alist
             '(font . "MonoLisa"))

;; Set font for text that should be displayed more like prose.
(set-face-attribute 'variable-pitch nil :family "Bookerly" :height 160)

;; display line numbers in the left margin of the window.
(use-package display-line-numbers
:elpaca nil
    :init
    (setq display-line-numbers-type t)
    (global-display-line-numbers-mode)
    )

;; (use-package whitespace
;; :elpaca nil
;;     :init
    
;;     ;;(setq whitespace-style '(face tabs tab-mark trailing))
;;     (global-whitespace-mode)
;;     )

(defvar my/side-window-slots
    '((helpful . 1) ;; 0 is the default
      (vterm . -1)
      (eldoc . 1)
      (aichat . 1)
      (python . -1)
      (R . -1)
      (Rhelp . 1)
      (Rdired . -1)
      (RWatch . -2)
      (xwidget-plot . -1)
      (dired-sidebar . -1))
    "The slot for different mode if used as side window,
this is for configuring `display-buffer-in-side-window',
configuring this would avoid buffer swallows other buffer's window
if they are side window.")

(defvar my/side-window-sides
    '((helpful . bottom) ;;bottom is the default
      (vterm . bottom)
      (eldoc . bottom)
      (aichat . bottom)
      (python . bottom)
      (R . bottom)
      (Rhelp . bottom)
      (Rdired . right)
      (RWatch . right)                  ;
      (xwidget-plot . right)
      (dired-sidebar . left)
      (pdf-outline . left))
    "The side different mode if used as side window,
this is for configuring `display-buffer-in-side-window',
configuring this would avoid buffer swallows other buffer's window
if they are side window.")

(setq window-combination-resize t
      ;; unless you have a really wide screen, always prefer
      ;; horizontal split (ale `split-window-below')
      split-width-threshold 300)

(blink-cursor-mode -1)

;; (use-package all-the-icons
;;     :if (display-graphic-p)
;;     :commands (all-the-icons-octicon
;;                all-the-icons-faicon
;;                all-the-icons-fileicon
;;                all-the-icons-wicon
;;                all-the-icons-material
;;                all-the-icons-alltheicon))

(use-package tab-bar
:elpaca nil
    :init
    (setq tab-bar-show 1
          tab-bar-close-button-show nil
          tab-bar-new-tab-choice "*scratch*"
          tab-bar-tab-hints t
          tab-bar-new-button-show nil
          tab-bar-format '(tab-bar-format-tabs-groups
                           tab-bar-separator))

    (general-create-definer my/tab-map
        :prefix "C-c TAB"
        :prefix-map 'my/tab-map)

    (my/tab-map
        "" '(:ignore t :which-key "Tab")
        "n" #'tab-bar-new-tab
        "c" #'tab-bar-close-tab
        "o" #'tab-bar-close-other-tabs
        "]" #'tab-bar-switch-to-next-tab
        "[" #'tab-bar-switch-to-prev-tab
        "{" #'tab-bar-history-back
        "}" #'tab-bar-history-forward
        "b" #'tab-bar-move-window-to-tab
        ;; move current window to a new tab (break current tab)
        "l" #'tab-bar-move-tab ;; move tab to the right
        "h" #'tab-bar-move-tab-backward ;; move tab to the left
        "g" #'tab-bar-change-tab-group ;; make group
        "TAB" #'tab-bar-switch-to-tab)

    )

(provide 'ui)
