;;; my-basics.el -*- lexical-binding: t; -*-

(setq user-full-name "Luca Fanselau")
(setq user-mail-address "luca.fanselau@outlook.com")

(setq mac-right-option-modifier 'meta)
(setq mac-option-modifier 'meta)

(setq warning-minimum-level :error)
(setq ring-bell-function 'ignore)

(setq initial-major-mode 'fundamental-mode)

(defconst IS-MAC (eq system-type 'darwin))
(defconst IS-LINUX (memq system-type '(gnu gnu/linux gnu/kfreebsd berkeley-unix)))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))

;; try to disable the auto backup behavior
;; as much as possible
(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil)

;; don't need to input yes or no
;; y or n is sufficient.
(setq use-short-answers t)

;; Press "TAB" key should not insert \t.
;; (setq-default indent-tabs-mode nil)

;; smooth scroll
(setq scroll-step 1
      scroll-conservatively 10000
      auto-window-vscroll nil)


;; Smooth scrolling
(setq pixel-scroll-precision-use-momentum t)
(pixel-scroll-precision-mode)

;; Load env path
(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(provide 'basics)
;;; my-basics ends here
