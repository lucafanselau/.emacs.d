
;; Elisp
(use-package
 elisp-autofmt
 :config (setq elisp-autofmt-python-bin "python3")
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

;; markdown
(use-package
 markdown-mode
 :mode
 (("\\.md\\'" . markdown-mode)
  ("\\.markdown\\'" . markdown-mode)
  ("\\.mdx\\'" . markdown-mode)))


;; python
(use-package
 python
 :elpaca nil
 :config
 (general-define-key
  :keymaps '(python-mode-map python-ts-mode-map) "C-c" nil))

(use-package
 pipenv
 :hook
 (((python-mode python-ts-mode) . pipenv-mode)
  ((python-mode python-ts-mode) . pipenv-activate))
 :init
 (setq pipenv-with-flycheck nil)
 (setq pipenv-with-projectile nil))


;; Typescript
(defun setup-typescript ()
  (require 'treesit-meow)
  (require 'eglot)
  ;; Register jsx elements
  (let* ((query
          '([(jsx_element) (jsx_self_closing_element)] @element))
         (inner-query
          '((jsx_element open_tag: (_) (_) * @children close_tag: (_))
            @element)))
    (meow-thing-register
     'tag
     `(lambda () (my/ts--get-element-children ',inner-query))
     `(lambda () (my/ts--get-element-bounds ',query)))
    (add-to-list 'meow-char-thing-table '(?t . tag)))
  ;; register functions
  (let* ((query '([(arrow_function) (function_declaration)] @element))
         (inner-query
          '([(arrow_function body: (_) @children)
             (function_declaration body: (_) @children)]
            @element)))
    (meow-thing-register
     'function
     `(lambda () (my/ts--get-element-children ',inner-query))
     `(lambda () (my/ts--get-element-bounds ',query)))
    (add-to-list 'meow-char-thing-table '(?f . function)))
  ;; register types
  (let* ((query '((type_alias_declaration) @element))
         (inner-query
          '((type_alias_declaration value: (_) @children) @element)))
    (meow-thing-register
     'type
     `(lambda () (my/ts--get-element-children ',inner-query))
     `(lambda () (my/ts--get-element-bounds ',query)))
    (add-to-list 'meow-char-thing-table '(?T . type)))
  ;; register properties
  (let* ((query
          '([(property_signature)
             (pair key: (_) value: (_))
             (shorthand_property_identifier)]
            @element))
         (inner-query
          '([(property_signature type: (_) @children)
             (pair value: (_) @children)]
            @element)))
    (meow-thing-register
     'property
     `(lambda () (my/ts--get-element-children ',inner-query))
     `(lambda () (my/ts--get-element-bounds ',query)))
    (add-to-list 'meow-char-thing-table '(?P . property)))

  ;; add inlay hints for eglot mode
  (add-to-list
   'eglot-server-programs
   '((js-mode
      js-ts-mode tsx-ts-mode typescript-ts-base-mode typescript-mode)
     "typescript-language-server" "--stdio"
     :initializationOptions
     (:preferences
      (:includeInlayParameterNameHints
       "all"
       :includeInlayParameterNameHintsWhenArgumentMatchesName t
       :includeInlayFunctionParameterTypeHints t
       :includeInlayVariableTypeHints t
       :includeInlayVariableTypeHintsWhenTypeMatchesName t
       :includeInlayPRopertyDeclarationTypeHints t
       :includeInlayFunctionLikeReturnTypeHints t
       :includeInlayEnumMemberValueHints t)))))
(add-hook 'typescript-ts-base-mode-hook #'setup-typescript)

(use-package zig-mode :mode "\\.zig\\'")

(provide 'langs)
