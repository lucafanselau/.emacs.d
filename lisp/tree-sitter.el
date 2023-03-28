;; bundled tree sitter setup
(use-package treesit
  :elpaca nil
  :init
  (setq treesit-extra-load-path '("~/.emacs.d/grammar"))
  :mode ((".*\\.ts\\'" . typescript-ts-mode)
	 (".*\\.tsx\\'" . tsx-ts-mode)))


;; basic elisp stuff
(use-package elisp
  :elpaca nil
  :config
  (my/code-map
   ’("k" . describe-symbol)))


(use-package eglot
:elpaca nil
;; register all languages where the we want lsp services
:hook (typescript-ts-base-mode . eglot-ensure)
:config
(my/code-map
 "c" #'comment-region
 "a" #'eglot-code-actions))

(defun my/error-inner ()
  (require 'dash)
  (let* ((pt (point))
        (before-bounds nil)
        (after-bounds nil)
    ;; Get Flymake diagnostics for the accessible buffer.
	(diagnostics (flymake-diagnostics))
	(positions (-map (lambda (diag) (cons (flymake-diagnostic-beg diag) (flymake-diagnostic-end diag))) diagnostics)))
    ;; this kinda assums that diagnostics are always sorted in accending order of their BEG
    ;; find the maximum END that is before the point
    (let* ((beginnings (-concat (-filter (lambda (e) (< e pt))  (-map (lambda (range) (cdr range)) positions) ) '(0)))
	   (endings (-concat (-filter (lambda (b) (< pt b)) (-map (lambda (range) (car range)) positions) ) (list (point-max))))
	   )
      (cons (-max beginnings) (-min endings))
      )
    ;; Check for the first error before point.
      ))
  
(defun my/error-bounds ()
  (require 'dash)
  (let* ((pt (point))
        (before-bounds nil)
        (after-bounds nil)
    ;; Get Flymake diagnostics for the accessible buffer.
	(diagnostics (flymake-diagnostics))
	(positions (-map (lambda (diag) (cons (flymake-diagnostic-beg diag) (flymake-diagnostic-end diag))) diagnostics)))
    ;; this kinda assums that diagnostics are always sorted in accending order of their BEG
    ;; find the maximum END that is before the point
    (let* ((beginnings (-filter (lambda (e) (<= e pt)) (-concat (-map (lambda (range) (car range)) positions) '(0))))
	   (endings (-filter (lambda (b) (<= pt b)) (-concat (-map (lambda (range) (cdr range)) positions) (list (point-max)))))
	   )
      (cons (-max beginnings) (-min endings))
      )
    ;; Check for the first error before point.
      ))


(use-package flymake
  :elpaca nil
  :config
  (my/code-map
    "e" #'consult-flymake)

  (meow-thing-register 'error #'my/error-inner #'my/error-bounds)
  (add-to-list 'meow-char-thing-table '(?e . error))
  )

;; (use-package prism
;;   :hook ((typescript-ts-base-mode lisp-mode) . prism-mode))



;; formatting
(use-package apheleia
:init
(apheleia-global-mode +1)
(my/buffer-map
 "f" :wk "format buffer" 'apheleia-format-buffer))





(provide 'tree-sitter)
