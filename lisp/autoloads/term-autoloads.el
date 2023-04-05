;;;###autoload
(defun my/vterm ()
  "open vterm at project root, if no root is found, open at the default-directory"
  (interactive)
  (let ((default-directory (my/project-root-or-default-dir)))
    (call-interactively #'vterm)))


;;;###autoload
(defun my/project-root-or-default-dir ()
  "If a project root is found, return it. Otherwise return `default-directory'."
  (if-let ((proj (project-current)))
    (project-root proj)
    default-directory))

(defvar my/npm-client "pnpm")

;;;###autoload
(defun my/get-scripts ()
  (require 'json)
  (let* ((package-json
          (f-join (my/project-root-or-default-dir) "package.json"))
         (parsed-json (json-read-file package-json)))
    (alist-get 'scripts parsed-json)))


;;;###autoload
(defun my/vterm-run-command (cmd name)
  "Run the command CMD In a new vterm buffer with the name NAME if it not exists, otherwise switch to the existing buffer of name NAME and execute command CMD."
  (require 'vterm)
  (let ((buffer (get-buffer name))
        (default-directory (my/project-root-or-default-dir)))
    (if buffer
        (progn
          (switch-to-buffer buffer)
          (vterm-send-C-c)
          (vterm-send-string cmd)
          (vterm-send-return))
      (vterm name)
      (vterm-send-string cmd)
      (vterm-send-return))))


;;;###autoload
(defun my/run-scripts ()
  (interactive)
  (require 'consult)
  (require 'dash)
  (if (not (buffer-file-name (current-buffer)))
      (hack-dir-local-variables-non-file-buffer))
  (let* ((scripts (my/get-scripts))
         (scripts
          (-map (lambda (s) (format "run %s" (car s))) scripts))
         (scripts (-concat scripts '("install")))
         (script (consult--read scripts :prompt "Script: "))
         (cmd (format "%s %s" my/npm-client script)))
    (my/vterm-run-command cmd (format "*script: %s*" script))))

(provide 'term-autoloads)
