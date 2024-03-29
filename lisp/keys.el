
(use-package
 meow
 :demand t
 :ensure t
 :config
 (defun meow-setup ()
   (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
   (meow-motion-overwrite-define-key
    '("j" . meow-next) '("k" . meow-prev) '("<escape>" . ignore))
   (meow-leader-define-key
    ;; SPC j/k will run the original command in MOTION state.
    ;; '("j" . "H-j")
    ;;'("k" . "H-k")
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    ;;'("/" . meow-keypad-describe-key)
    '("?" . meow-cheatsheet))
   (meow-normal-define-key
    '("0" . meow-expand-0)
    '("9" . meow-expand-9)
    '("8" . meow-expand-8)
    '("7" . meow-expand-7)
    '("6" . meow-expand-6)
    '("5" . meow-expand-5)
    '("4" . meow-expand-4)
    '("3" . meow-expand-3)
    '("2" . meow-expand-2)
    '("1" . meow-expand-1)
    '("-" . negative-argument)
    '(";" . meow-reverse)
    '("," . meow-inner-of-thing)
    '("." . meow-bounds-of-thing)
    '("[" . meow-beginning-of-thing)
    '("]" . meow-end-of-thing)
    '("a" . meow-append)
    '("A" . meow-open-below)
    '("b" . meow-back-word)
    '("B" . meow-back-symbol)
    '("c" . meow-change)
    '("d" . meow-delete)
    '("D" . meow-backward-delete)
    '("e" . meow-next-word)
    '("E" . meow-next-symbol)
    '("f" . meow-find)
    '("g" . meow-cancel-selection)
    '("G" . meow-grab)
    '("h" . meow-left)
    '("H" . meow-left-expand)
    '("i" . meow-insert)
    '("I" . meow-open-above)
    '("j" . meow-next)
    '("J" . meow-next-expand)
    '("k" . meow-prev)
    '("K" . meow-prev-expand)
    '("l" . meow-right)
    '("L" . meow-right-expand)
    '("m" . meow-join)
    '("n" . meow-search)
    '("o" . meow-block)
    '("O" . meow-to-block)
    '("p" . meow-yank)
    '("q" . meow-quit)
    '("Q" . meow-goto-line)
    '("r" . meow-replace)
    '("R" . meow-swap-grab)
    '("s" . meow-kill)
    '("t" . meow-till)
    '("u" . meow-undo)
    '("U" . undo-redo)
    '("v" . meow-visit)
    '("w" . meow-mark-word)
    '("W" . meow-mark-symbol)
    '("x" . meow-line)
    '("X" . meow-goto-line)
    '("y" . meow-save)
    '("Y" . meow-sync-grab)
    '("z" . meow-pop-selection)
    '("'" . repeat)
    '("C-d" . meow-page-down)
    '("C-u" . meow-page-up)
    '("<escape>" . ignore)

    ;; 3rd party bindings
    '("S" . embrace-commander)))

 (require 'meow) (meow-setup) (meow-global-mode 1))



(defun my/meow-define-keys (state mode &rest keybinds)
  "Wrapper around meow-define-keys which only defines a keybind for a specific mode"
  (let (modified-keybinds)
    (pcase-dolist (`(,key . ,fun) keybinds)
      (push (cons
             key
             `(lambda ()
                (interactive)
                (call-interactively
                 (if (eq major-mode ',mode)
                     #',fun
                   (key-binding ,key)))))
            modified-keybinds))
    (apply 'meow-define-keys state modified-keybinds)))


(elpaca-wait)


(use-package
 embrace
 :elpaca (:type git :host github :repo "cute-jumper/embrace.el")
 :bind (("C-M-s-#" . embrace-commander))
 :config (add-hook 'org-mode-hook 'embrace-org-mode-hook)
 (defun embrace-markdown-mode-hook ()
   (dolist (lst
            '((?* "*" . "*")
              (?\  "\\" . "\\")
              (?$ "$" . "$")
              (?/ "/" . "/")))
     (embrace-add-pair (car lst) (cadr lst) (cddr lst))))
 (add-hook 'markdown-mode-hook 'embrace-markdown-mode-hook))

(meow-normal-define-key '("S" . embrace-commander))


(use-package
 better-jumper
 :config

 ; this is the key here. This advice makes it so you only set a jump point
 ; if you move more than one line with whatever command you call. For example
 ; if you add this advice around evil-next-line, you will set a jump point
 ; if you do 10 j, but not if you just hit j. I did not write this code, I 
 ; I found it a while back and updated it to work with better-jumper.
 (defun my/jump-advice (oldfun &rest args)
   (let ((old-pos (point)))
     (apply oldfun args)
     (when (> (abs
               (- (line-number-at-pos old-pos)
                  (line-number-at-pos (point))))
              1)
       (better-jumper-set-jump old-pos))))


 ;; todo: add all this
 )

;; (use-package paredit :hook (prog-mode . enable-paredit-mode))


;; (use-package
;;  vundo
;;  :config
;;  (my/meow-define-keys 'normal 'prog-mode "C-c C-u" 'vundo))

;; Use puni-mode globally and disable it for term-mode.
;; (use-package
;;  puni
;;  :defer t
;;  :init
;;  ;; The autoloads of Puni are set up so you can enable `puni-mode` or
;;  ;; `puni-global-mode` before `puni` is actually loaded. Only after you press
;;  ;; any key that calls Puni commands, it's loaded.
;;  (puni-global-mode)
;;  (add-hook 'term-mode-hook #'puni-disable-puni-mode))

(use-package
 embrace
 :elpaca (:type git :host github :repo "cute-jumper/embrace.el")
 :bind (("C-M-s-#" . embrace-commander))
 :config

 (defun embrace-jsx-mode-hook ()
   (embrace-add-pair ?c "{/*" "*/}")
   (print "hello"))
 (add-hook 'tsx-ts-mode-hook 'embrace-jsx-mode-hook)
 ;; (add-hook 'org-mode-hook 'embrace-org-mode-hook)
 ;; (defun embrace-markdown-mode-hook ()
 ;;   (dolist (lst '((?* "*" . "*")
 ;;                  (?\ "\\" . "\\")
 ;;                  (?$ "$" . "$")
 ;;                  (?/ "/" . "/")))
 ;;     (embrace-add-pair (car lst) (cadr lst) (cddr lst))))
 ;; (add-hook 'markdown-mode-hook 'embrace-markdown-mode-hook)
 )


(provide 'keys)
