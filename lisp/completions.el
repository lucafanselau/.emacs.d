;; Enable vertico
(use-package
 vertico
 :init (vertico-mode)

 ;; Different scroll margin
 ;; (setq vertico-scroll-margin 0)

 ;; Show more candidates
 ;; (setq vertico-count 20)

 ;; Grow and shrink the Vertico minibuffer
 ;; (setq vertico-resize t)

 ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
 ;; (setq vertico-cycle t)
 :bind (:map vertico-map ("C-j" . vertico-next) ("C-k" . vertico-previous)))


;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :elpaca nil :init (savehist-mode))

;; A few more useful configurations...
(use-package
 emacs
 :elpaca nil
 :init
 ;; Add prompt indicator to `completing-read-multiple'.
 ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
 (defun crm-indicator (args)
   (cons
    (format "[CRM%s] %s"
            (replace-regexp-in-string
             "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" "" crm-separator)
            (car args))
    (cdr args)))
 (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

 ;; Do not allow the cursor in the minibuffer prompt
 (setq minibuffer-prompt-properties
       '(read-only t cursor-intangible t face minibuffer-prompt))
 (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

 ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
 ;; Vertico commands are hidden in normal buffers.
 ;; (setq read-extended-command-predicate
 ;;       #'command-completion-default-include-p)

 ;; Enable recursive minibuffers
 (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
(use-package
 orderless
 :init
 ;; Configure a custom style dispatcher (see the Consult wiki)
 ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
 ;;       orderless-component-separator #'orderless-escapable-split-on-space)
 (setq
  completion-styles '(orderless basic)
  completion-category-defaults nil
  completion-category-overrides '((file (styles partial-completion)))
  ;; personal preference (no cycling at all)
  completion-cycle-threshold nil))

;; Example configuration for Consult
(use-package
 consult
 :ensure t
 :config (message "consult loaded")

 ;; Replace bindings. Lazily loaded due by `use-package'.
 ;; :bind (;; C-c bindings (mode-specific-map)
 ;;        ("C-c M-x" . consult-mode-command)
 ;;        ("C-c h" . consult-history)
 ;;        ("C-c k" . consult-kmacro)
 ;;        ("C-c m" . consult-man)
 ;;  ("C-c i" . consult-info)
 ;;  ("C-c ," . consult-buffer)
 ;;  ("C-c :" . execute-extended-command)
 ;;  ;; ([remap execute-extended-command] . consult-mode-command)
 ;;        ([remap Info-search] . consult-info)
 ;;        ;; C-x bindings (ctl-x-map)
 ;;        ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
 ;;        ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
 ;;        ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
 ;;        ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
 ;;        ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
 ;;        ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
 ;;        ;; Custom M-# bindings for fast register access
 ;;        ("M-#" . consult-register-load)
 ;;        ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
 ;;        ("C-M-#" . consult-register)
 ;;        ;; Other custom bindings
 ;;        ("M-y" . consult-yank-pop)                ;; orig. yank-pop
 ;;        ;;  C-s bindings (goto-map)
 ;;        ;; (" C-s e" . consult-compile-error)
 ;;        (" C-s e" . consult-flymake)               ;; Alternative: consult-flycheck
 ;;  (" C-s g" . consult-goto-line)             ;; orig. goto-line
 ;;        ;; (" C-s M-g" . consult-goto-line)           ;; orig. goto-line
 ;;        (" C-s o" . consult-outline)               ;; Alternative: consult-org-heading
 ;;        (" C-s m" . consult-mark)
 ;;        (" C-s k" . consult-global-mark)
 ;;        (" C-s i" . consult-imenu)
 ;;        (" C-s I" . consult-imenu-multi)
 ;;        ;;  C-s bindings (search-map)
 ;;        (" C-s d" . consult-find)
 ;;        (" C-s D" . consult-locate)
 ;;        (" C-s g" . consult-grep)
 ;;        (" C-s G" . consult-git-grep)
 ;;        (" C-s r" . consult-ripgrep)
 ;;        (" C-s l" . consult-line)
 ;;        (" C-s L" . consult-line-multi)
 ;;        (" C-s k" . consult-keep-lines)
 ;;        (" C-s u" . consult-focus-lines)
 ;;        ;; Isearch integration
 ;;        (" C-s e" . consult-isearch-history)
 ;;        :map isearch-mode-map
 ;;        ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
 ;;        (" C-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
 ;;        (" C-s l" . consult-line)                  ;; needed by consult-line to detect isearch
 ;;        (" C-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
 ;;        ;; Minibuffer history
 ;;        :map minibuffer-local-map
 ;;        ("M-s" . consult-history)                 ;; orig. next-matching-history-element
 ;;        ("M-r" . consult-history))                ;; orig. previous-matching-history-element


 ;; Enable automatic preview at point in the *Completions* buffer. This is
 ;; relevant when you use the default completion UI.
 :hook (completion-list-mode . consult-preview-at-point-mode)

 ;; The :init configuration is always executed (Not lazy)
 :init

 (general-define-key "C-c y" #'consult-yank-from-kill-ring)
 (my/search-map "l" #'consult-line)

 ;; Optionally configure the register formatting. This improves the register
 ;; preview for `consult-register', `consult-register-load',
 ;; `consult-register-store' and the Emacs built-ins.
 (setq
  register-preview-delay 0.5
  register-preview-function #'consult-register-format)

 ;; Optionally tweak the register preview window.
 ;; This adds thin lines, sorting and hides the mode line of the window.
 (advice-add #'register-preview :override #'consult-register-window)

 ;; Use Consult to select xref locations with preview
 (setq
  xref-show-xrefs-function #'consult-xref
  xref-show-definitions-function #'consult-xref)

 ;; Configure other variables and modes in the :config section,
 ;; after lazily loading the package.
 :config

 ;; Optionally configure preview. The default value
 ;; is 'any, such that any key triggers the preview.
 ;; (setq consult-preview-key 'any)
 ;; (setq consult-preview-key "M-.")
 ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
 ;; For some commands and buffer sources it is useful to configure the
 ;; :preview-key on a per-command basis using the `consult-customize' macro.
 (consult-customize
  consult-theme
  :preview-key
  '(:debounce 0.2 any)
  consult-ripgrep
  consult-git-grep
  consult-grep
  consult-bookmark
  consult-recent-file
  consult-xref
  consult--source-bookmark
  consult--source-file-register
  consult--source-recent-file
  consult--source-project-recent-file
  ;; :preview-key "M-."
  :preview-key '(:debounce 0.4 any))

 ;; Optionally configure the narrowing key.
 ;; Both < and C-+ work reasonably well.
 (setq consult-narrow-key "<") ;; "C-+"

 ;; Optionally make narrowing help available in the minibuffer.
 ;; You may want to use `embark-prefix-help-command' or which-key instead.
 ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

 ;; By default `consult-project-function' uses `project-root' from project.el.
 ;; Optionally configure a different project root function.
 ;;;; 1. project.el (the default)
 ;; (setq consult-project-function #'consult--default-project--function)
 ;;;; 2. vc.el (vc-root-dir)
 ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
 ;;;; 3. locate-dominating-file
 ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
 ;;;; 4. projectile.el (projectile-project-root)
 ;; (autoload 'projectile-project-root "projectile")
 ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
 ;;;; 5. No project support
 ;; (setq consult-project-function nil)
 )

;; Enable rich annotations using the Marginalia package
(use-package
 marginalia
 ;; Either bind `marginalia-cycle' globally or only in the minibuffer
 :bind
 (("M-A" . marginalia-cycle)
  :map
  minibuffer-local-map
  ("M-A" . marginalia-cycle))

 ;; The :init configuration is always executed (Not lazy!)
 :init

 ;; Must be in the :init section of use-package such that the mode gets
 ;; enabled right away. Note that this forces loading the package.
 (marginalia-mode))


;; And here we go with corfu

(use-package
 corfu
 :elpaca (:files (:defaults "extensions/*"))
 ;; Optional customizations
 :custom
 (corfu-cycle t) ;; Enable cycling for `corfu-next/previous'
 ;; (corfu-auto t)                 ;; Enable auto completion
 (corfu-separator ?\s) ;; Orderless field separator
 ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
 ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
 ;; (corfu-preview-current nil)    ;; Disable current candidate preview
 ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
 ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
 ;; (corfu-scroll-margin 5)        ;; Use scroll margin

 ;; Enable Corfu only for certain modes.
 ;; :hook ((prog-mode . corfu-mode)
 ;;        (shell-mode . corfu-mode)
 ;;        (eshell-mode . corfu-mode))

 ;; Recommended: Enable Corfu globally.
 ;; This is recommended since Dabbrev can be used globally (M-/).
 ;; See also `corfu-excluded-modes'.
 :bind
 (:map
  corfu-map
  ("C-j" . #'corfu-next)
  ("C-k" . #'corfu-previous)
  ("<escape>" . #'corfu-quit)
  ("<return>" . #'corfu-insert)
  ("M-d" . #'corfu-info-documentation)
  ("M-l" . #'corfu-info-location)
  ("M-t" . #'corfu-popupinfo-toggle)
  ("M-n" . #'corfu-popupinfo-scroll-up)
  ("M-p" . #'corfu-popupinfo-scroll-down))
 :init (global-corfu-mode))

(use-package
 corfu-popupinfo
 :elpaca nil
 :after corfu
 :hook (corfu-mode . corfu-popupinfo-mode))

(use-package
 kind-icon
 :demand t
 :after corfu
 :custom
 (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
 :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


;; A few more useful configurations...
(use-package
 emacs
 :elpaca nil
 :init
 ;; TAB cycle if there are only few candidates
 (setq completion-cycle-threshold 3)

 ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
 ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
 ;; (setq read-extended-command-predicate
 ;;       #'command-completion-default-include-p)

 ;; Enable indentation+completion using the TAB key.
 ;; `completion-at-point' is often bound to M-TAB.
 (setq tab-always-indent 'complete))

;; Add extensions
(use-package
 cape
 ;; Bind dedicated completion commands
 ;; Alternative prefix keys: C-c p, M-p, M-+, ...
 :bind
 (("C-SPC" . completion-at-point) ;; capf
  ;; ("C-c p t" . complete-tag)        ;; etags
  ("C-," . cape-dabbrev) ;; or dabbrev-completion
  ;; ("C-c p h" . cape-history)
  ;; ("C-c p f" . cape-file)
  ;; ("C-c p k" . cape-keyword)
  ;; ("C-c p s" . cape-symbol)
  ;; ("C-c p a" . cape-abbrev)
  ;; ("C-c p i" . cape-ispell)
  ;; ("C-c p l" . cape-line)
  ;; ("C-c p w" . cape-dict)
  ;; ("C-c p \\" . cape-tex)
  ;; ("C-c p _" . cape-tex)
  ;; ("C-c p ^" . cape-tex)
  ;; ("C-c p &" . cape-sgml)
  ;; ("C-c p r" . cape-rfc1345)
  )
 :init
 ;; Add `completion-at-point-functions', used by `completion-at-point'.
 (add-to-list 'completion-at-point-functions #'cape-dabbrev)
 (add-to-list 'completion-at-point-functions #'cape-file)
 ;;(add-to-list 'completion-at-point-functions #'cape-history)
 ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
 ;;(add-to-list 'completion-at-point-functions #'cape-tex)
 ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
 ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
 ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
 ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
 ;;(add-to-list 'completion-at-point-functions #'cape-dict)
 ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
 ;;(add-to-list 'completion-at-point-functions #'cape-line)
 )

(provide 'completions)
