
(use-package atom-one-dark-theme :ensure t)

(use-package
 ligature
 :config
 ;; Enable the "www" ligature in every possible major mode
 (ligature-set-ligatures 't '("www"))
 ;; Enable traditional ligature support in eww-mode, if the
 ;; `variable-pitch' face supports it
 (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
 ;; Enable all Cascadia Code ligatures in programming modes
 (ligature-set-ligatures
  'prog-mode
  '("|||>"
    "<|||"
    "<==>"
    "<!--"
    "####"
    "~~>"
    "***"
    "||="
    "||>"
    ":::"
    "::="
    "=:="
    "==="
    "==>"
    "=!="
    "=>>"
    "=<<"
    "=/="
    "!=="
    "!!."
    ">=>"
    ">>="
    ">>>"
    ">>-"
    ">->"
    "->>"
    "-->"
    "---"
    "-<<"
    "<~~"
    "<~>"
    "<*>"
    "<||"
    "<|>"
    "<$>"
    "<=="
    "<=>"
    "<=<"
    "<->"
    "<--"
    "<-<"
    "<<="
    "<<-"
    "<<<"
    "<+>"
    "</>"
    "###"
    "#_("
    "..<"
    "..."
    "+++"
    "/=="
    "///"
    "_|_"
    "www"
    "&&"
    "^="
    "~~"
    "~@"
    "~="
    "~>"
    "~-"
    "**"
    "*>"
    "*/"
    "||"
    "|}"
    "|]"
    "|="
    "|>"
    "|-"
    "{|"
    "[|"
    "]#"
    "::"
    ":="
    ":>"
    ":<"
    "$>"
    "=="
    "=>"
    "!="
    "!!"
    ">:"
    ">="
    ">>"
    ">-"
    "-~"
    "-|"
    "->"
    "--"
    "-<"
    "<~"
    "<*"
    "<|"
    "<:"
    "<$"
    "<="
    "<>"
    "<-"
    "<<"
    "<+"
    "</"
    "#{"
    "#["
    "#:"
    "#="
    "#!"
    "##"
    "#("
    "#?"
    "#_"
    "%%"
    ".="
    ".-"
    ".."
    ".?"
    "+>"
    "++"
    "?:"
    "?="
    "?."
    "??"
    ";;"
    "/*"
    "/="
    "/>"
    "//"
    "__"
    "~~"
    "(*"
    "*)"
    "\\\\"
    "://"))
 ;; Enables ligature checks globally in all buffers. You can also do it
 ;; per mode with `ligature-mode'.
 (global-ligature-mode t))

(use-package smart-mode-line-atom-one-dark-theme :ensure t)
(use-package
 smart-mode-line
 :ensure t
 :defer 0.2
 :init
 (setq sml/no-confirm-load-theme t)
 (setq sml/theme 'atom-one-dark)
 :config (sml/setup))

(use-package
 rainbow-delimiters
 :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo :hook (prog-mode . hl-todo-mode))

(elpaca-wait)

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'tango t))
    ('dark (load-theme 'atom-one-dark t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)
;; always start with dark
(my/apply-theme 'dark)

(provide 'theme)
