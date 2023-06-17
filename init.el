;;; init.el -*- lexical-binding: t; -*-

;; increase gc threshold to speedup starting up
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

;; font config
(cond
 ((font-exists-p "MonoLisa")
  (set-frame-font "MonoLisa:weight=bold:spacing=100:size=18" nil t))

 ((font-exists-p "Cascadia Mono")
  (set-face-attribute 'default nil :font "Cascadia Code" :height 160))
 ((font-exists-p "JetBrains Mono")
  (set-face-attribute 'default nil
                      :font "JetBrains Mono"
                      :height 120)))

;; global config

(defvar my/config-dir (file-name-concat user-emacs-directory "lisp")
  "the directory of my configuration.")
(defvar my/autoloads-dir (file-name-concat my/config-dir "autoloads")
  "the directory of my autoloded functions.")

(defvar my/autoloads-file
  (file-name-concat my/autoloads-dir "loaddefs.el")
  "the directory of my autoloded functions.")

(push my/config-dir load-path)
(push my/autoloads-dir load-path)
(setq custom-file (file-name-concat user-emacs-directory "custom.el"))

(defvar elpaca-installer-version 0.3)
(defvar elpaca-directory
  (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory
  (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory
  (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order
  '(elpaca
    :repo "https://github.com/progfolio/elpaca.git"
    :ref nil
    :files (:defaults (:exclude "extensions"))
    :build (:not elpaca--activate-package)))
(let* ((repo (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list
   'load-path
   (if (file-exists-p build)
       build
     repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (condition-case-unless-debug err
        (if-let ((buffer
                  (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop
                   (call-process "git"
                                 nil
                                 buffer
                                 t
                                 "clone"
                                 (plist-get order :repo)
                                 repo)))
                 ((zerop
                   (call-process "git"
                                 nil
                                 buffer
                                 t
                                 "checkout"
                                 (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop
                   (call-process
                    emacs
                    nil
                    buffer
                    nil
                    "-Q"
                    "-L"
                    "."
                    "--batch"
                    "--eval"
                    "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
          (kill-buffer buffer)
          (error
           "%s"
           (with-current-buffer buffer
             (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(add-hook
 'elpaca-after-init-hook
 (lambda ()
   (message "Emacs loaded in %s with %d garbage collections."
            (format "%.2f seconds"
                    (float-time
                     (time-subtract (current-time) before-init-time)))
            gcs-done)))

(setq
 use-package-expand-minimally t
 ;; use-package is a macro. Don't let the macro expands into
 ;; codes with too much of irrelevant checks.
 use-package-always-ensure nil
 ;; Straight is my package manager, don't let package.el get
 ;; involved.
 use-package-always-defer t
 ;; This is a useful trick to speed up your startup time. Only
 ;; use `require' when it's necessary. By setting the
 ;; `use-package-always-defer' option to t, use-package won't
 ;; call `require' in all cases unless you explicitly include
 ;; :demand t'. This will prevent unnecessary package loading and
 ;; speed up your Emacs startup time.
 straight-check-for-modifications nil
 ;; This is a useful trick to further optimize your startup
 ;; time. Instead of using `straight-check-for-modifications' to
 ;; check if a package has been modified, you can manually
 ;; rebuild the package by `straight-rebuild-package' when you
 ;; know its source code has changed. This avoids the overhead of
 ;; the check. Make sure you know what you are doing here when
 ;; setting this option.
 )
;;debug-on-error t)

;; Install use-package support
(elpaca
 elpaca-use-package
 ;; Enable :elpaca use-package keyword.
 (elpaca-use-package-mode)
 ;; Assume :elpaca t unless otherwise specified.
 (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

(load my/autoloads-file)
;; Here the actual config starts
(require 'utils)
(require 'basics)
(require 'keys)
(require 'completions)
(require 'git)
(require 'manager)
(require 'workspace)
(require 'theme)
(require 'tree-sitter)
(require 'ui)
(require 'langs)
(require 'term)
(require 'spell)
(require 'fwm)

(elpaca-wait)


;; after that some last settings
(general-define-key
 :keymaps 'meow-normal-state-keymap "/" my/search-map)

;; after started up, reset GC threshold to normal.
(run-with-idle-timer
 4 nil
 (lambda ()
   "Clean up gc."
   (setq gc-cons-threshold 67108864) ; 64M
   (setq gc-cons-percentage 0.1) ; original value
   (garbage-collect)))

(provide 'init)
