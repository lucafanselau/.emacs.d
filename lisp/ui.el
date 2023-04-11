
(set-display-table-slot standard-display-table 'truncation 32)
(set-display-table-slot standard-display-table 'wrap 32)

;; by default when a long line is truncated, emacs displays
;; a "$" sign at the border of window, which is ugly,
;; replace "$" with " "
;; see discussion here: URL `https://emacs.stackexchange.com/questions/54817/remove-dollar-sign-at-beginning-of-line'

;; set default font
;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono"))

;; Set font for text that should be displayed more like prose.
(set-face-attribute 'variable-pitch nil
                    :family "Bookerly"
                    :height 160)

;; display line numbers in the left margin of the window.
(use-package
 display-line-numbers
 :elpaca nil
 :init
 (setq display-line-numbers-type t)
 (global-display-line-numbers-mode))

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
    (RWatch . right) ;
    (xwidget-plot . right)
    (dired-sidebar . left)
    (pdf-outline . left))
  "The side different mode if used as side window,
this is for configuring `display-buffer-in-side-window',
configuring this would avoid buffer swallows other buffer's window
if they are side window.")

(setq
 window-combination-resize t
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


(provide 'ui)
