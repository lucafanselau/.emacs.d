
;; ORG BABEL preperation

(defun my/org-babel-edit:python ()
  "Edit python src block with lsp support by tangling the block and
then setting the org-edit-special buffer-file-name to the
absolute path. Finally load eglot."
  (interactive)

  ;; org-babel-get-src-block-info returns lang, code_src, and header
  ;; params; Use nth 2 to get the params and then retrieve the :tangle
  ;; to get the filename
  (setq mb/tangled-file-name
        (expand-file-name
         (assoc-default
          :tangle (nth 2 (org-babel-get-src-block-info)))))

  ;; tangle the src block at point 
  (org-babel-tangle '(4))
  (org-edit-special)

  ;; Now we should be in the special edit buffer with python-mode. Set
  ;; the buffer-file-name to the tangled file so that pylsp and
  ;; plugins can see an actual file.
  (setq-local buffer-file-name mb/tangled-file-name)
  (eglot-ensure))

(defun my/org-setup-latex ()
  ;; better latex fragments on retina displays
  (setq org-latex-create-formula-image-program 'dvisvgm)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.75)))


(use-package
 org
 :elpaca nil
 :init

 ;; Improve org mode looks
 (setq
  org-startup-indented t
  org-pretty-entities t
  org-hide-emphasis-markers t
  org-startup-with-inline-images t
  org-image-actual-width '(300))

 (org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t) (python . t) (shell . t)))

 (setq org-babel-python-command "pipenv run python")

 :hook (org-mode . my/org-setup-latex)

 :config
 (add-to-list
  'org-entities-user
  '("models" "\\models" t "&models;" "|=" "|=" "⊨"))
 (add-to-list
  'org-entities-user
  '("implies" "\\implies" t "&implies;" "=>" "=>" "⇒"))
 (add-to-list
  'org-entities-user '("iff" "\\iff" t "&iff;" "<=>" "<=>" "⇔"))
 ;; update the faces, i don't need variable fonts
 (-map
  (lambda (it)
    (custom-set-faces `(,it ((t (:inherit default :height 1.0))))))
  '(org-level-1
    org-level-2
    org-level-3
    org-level-4
    org-level-5
    org-level-6
    org-level-7
    org-level-8
    org-block)))

;; Modernise Org mode interface
(use-package
 org-modern
 :after org
 :hook (org-mode . global-org-modern-mode)
 :custom
 (org-modern-keyword nil)
 (org-modern-checkbox nil)
 (org-modern-block-name nil)
 (org-modern-table nil))

(use-package
 pdf-tools
 :mode ("\\.pdf\\'" . pdf-view-mode)

 :config
 (pdf-tools-install)
 (setq-default pdf-view-display-size 'fit-page)
 (setq-default pdf-view-display-size 'fit-page)
 (setq pdf-annot-activate-created-annotations t))

(use-package org-noter)


;; LaTeX previews
(use-package
 org-fragtog
 :after org
 :hook (add-hook 'org-mode-hook 'org-fragtog-mode)
 :custom
 (org-format-latex-options
  (plist-put org-format-latex-options :scale 1.2)))

;; org mode keymap
(my/notes-map
 "l"
 'org-roam-buffer-toggle
 "f"
 'org-roam-node-find
 "g"
 'org-roam-graph
 "i"
 'org-roam-node-insert
 "c"
 'org-roam-capture
 "j"
 'org-roam-dailies-capture-today)

(use-package
 org-download
 :after org
 :hook ((dired-mode org-mode) . org-download-enable)
 :config
 (my/notes-map "s" 'org-download-screenshot)
 (setq org-download-screenshot-method "screencapture -i %s"))

(use-package
 org-roam
 :ensure t
 :custom (org-roam-directory (file-truename "~/org/roam"))

 :config

 ;; If you're using a vertical completion framework, you might want a more informative completion interface
 (setq org-roam-node-display-template
       (concat
        "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
 (setq org-roam-database-connector 'sqlite-builtin)
 (org-roam-db-autosync-mode)
 ;; If using org-roam-protocol
 (require 'org-roam-protocol))


(use-package org-ql :after org)


(provide 'notes)
