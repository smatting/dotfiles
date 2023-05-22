;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; TODO
;; enable lsp-ui-mode in haskell

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))
(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-solarized-light)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq enable-local-variables t)

(setq auto-mode-alist (append '(("yaml\\.gotmpl\\'" . yaml-mode)
                                ("yml\\.gotmpl\\'" . yaml-mode))
                              auto-mode-alist ))

(add-hook! yaml-mode
  (setq truncate-lines t))

(setq lsp-file-watch-threshold 500000)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]nginz\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]charts\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]dist-buildah\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]dist-newstyle\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]libzauth-c\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.local\\'")
  )

;; lsp performance
(setq company-minimum-prefix-length 4) ;; default is 2
(setq lsp-idle-delay 0.500) ;; default 0.5
(after! gcmh
  (setq gcmh-high-cons-threshold 67108864))

(add-hook 'lsp-after-initialize-hook
          '(lambda ()
             (lsp--set-configuration
              '(:haskell (:plugin (:tactics (:globalOn :json-false)
                                   :alternateNumberFormat (:globalOn :json-false)
                                   )))
              )))

;; Keybindings!
;; Note: C-M-+ for zooming
;;
;; TODO: in flycheck-error-list-mode-map set mapping of "=" to flycheck-error-list-set-filter

(map! :map flycheck-error-list-mode-map
      "=" #'flycheck-error-list-set-filter)

(map! :leader "c z" #'lsp-treemacs-errors-list)
(map! :leader "j" #'helm-mark-ring)
(map! :leader "J" #'helm-global-mark-ring)
(map! :leader "SPC" #'projectile-switch-to-buffer)

(setq-default flycheck-disabled-checkers '(haskell haskell-stack haskell-stack-ghc))
;; (add-to-list 'flycheck-disabled-checkers 'emacs-lisp-checkdoc)

;; (add-hook 'haskell-mode-hook 'ormolu-format-on-save-mode)
;; doesnt work
;; (add-hook 'haskell-mode-hook 'lsp-ui-mode)

(unless window-system
    (when (getenv "DISPLAY")
      (defun xclip-cut-function (text &optional push)
        (with-temp-buffer
          (insert text)
          (call-process-region (point-min) (point-max) "xclip" nil 0 nil "-i" "-selection" "clipboard")))
      (defun xclip-paste-function()
        (let ((xclip-output (shell-command-to-string "xclip -o -selection clipboard")))
          (unless (string= (car kill-ring) xclip-output)
            xclip-output )))
      (setq interprogram-cut-function 'xclip-cut-function)
      (setq interprogram-paste-function 'xclip-paste-function)

      ))

(when (eq system-type 'darwin)
   (defun copy-from-osx ()
       (shell-command-to-string "pbpaste"))

   (defun paste-to-osx (text &optional push)
     (let ((process-connection-type nil))
       (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
         (process-send-string proc text)
         (process-send-eof proc))))
   (setq interprogram-cut-function 'paste-to-osx)
   (setq interprogram-paste-function 'copy-from-osx))

;; How to copy to Mac OX clipboard
;; 1. Select text
;; 2. SPC :
;; Select "shell-command-on-region"
;; 3. pbcopy RET

;; How to paste from Mac OX clipboard
;; 1. SPC u - for universal argument C-u
;; 2. SPC :
;; Select "shell-command-on-region"
;; 3. pbpaste RET

(setq dhall-command "dhall-that-does-not-exist-because-it-slows-down-emacs")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq nix-nixfmt-bin "nixpkgs-fmt")
