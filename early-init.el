;; (add-to-list 'default-frame-alist '(undecorated-round . t))

(setq package-enable-at-startup nil)

(defun font-exists-p (font)
  (if (null (x-list-fonts font))
      nil
    t))


;; increase gc threshold to speedup starting up
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

(setq inhibit-startup-message t)

;; no menu bar, toolbar, scroll bar
(setq default-frame-alist
      '((menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))

(setq native-comp-async-report-warnings-errors 'silent)

(provide 'early-init)
