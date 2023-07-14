
;; base config is shamelessly stolen from doom-emacs
;; https://github.com/doomemacs/doomemacs/blob/07fca786154551f90f36535bfb21f8ca4abd5027/modules/emacs/undo/config.el#L64

(use-package
 undo-fu
 :demand t
 :config
 ;; Increase undo history limits to reduce likelihood of data loss
 (setq
  undo-limit 400000 ; 400kb (default is 160kb)
  undo-strong-limit 3000000 ; 3mb   (default is 240kb)
  undo-outer-limit 48000000) ; 48mb  (default is 24mb)

 (define-minor-mode undo-fu-mode
   "Enables `undo-fu' for the current session."
   :keymap
   (let ((map (make-sparse-keymap)))
     (define-key map [remap undo] #'undo-fu-only-undo)
     (define-key map [remap redo] #'undo-fu-only-redo)
     (define-key map (kbd "C-_") #'undo-fu-only-undo)
     (define-key map (kbd "M-_") #'undo-fu-only-redo)
     (define-key map (kbd "C-M-_") #'undo-fu-only-redo-all)
     (define-key map (kbd "C-x r u") #'undo-fu-session-save)
     (define-key map (kbd "C-x r U") #'undo-fu-session-recover)
     map)
   :init-value nil
   :global t)

 (undo-fu-mode t))


(use-package
 undo-fu-session
 :hook (undo-fu-mode . global-undo-fu-session-mode)
 :custom
 (undo-fu-session-directory
  (concat user-emacs-directory ".undo-cache/"))
 :config
 (setq undo-fu-session-incompatible-files
       '("\\.gpg$" "/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))

 (when (executable-find "zstd")
   ;; There are other algorithms available, but zstd is the fastest, and speed
   ;; is our priority within Emacs
   (setq undo-fu-session-compression 'zst)))


(use-package
 vundo
 :defer t
 :config
 (setq
  vundo-glyph-alist vundo-unicode-symbols
  vundo-compact-display t))

(provide 'undo)
