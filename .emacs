
;; the package manager
(require 'package)
(setq
   package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                      ("org" . "http://orgmode.org/elpa/")
                      ("melpa" . "http://melpa.org/packages/")
                      ("melpa-stable" . "http://stable.melpa.org/packages/"))
   package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
;;(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package) ;; )
(require 'use-package)

; Use the command key as meta and reset the option key:
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; Set the debug option to enable a backtrace when a
;; problem occurs.
;;(setq debug-on-error t)
(add-hook 'after-init-hook
          '(lambda () (setq debug-on-error t)))

;; Show column-number in the mode line
(column-number-mode 1)

;; Goto line support:
(define-key global-map "\C-cl" 'goto-line)

;; Toggle fullscreen mode:
(define-key global-map "\C-cf" 'toggle-frame-fullscreen)

;; Display time:
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; Display colors
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "white")

;; highlight the region between point and mark
(setq transient-mark-mode t)

;; Make all modes that suppport it use font lock:
(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-sbt-command "/Users/bbunch/bin/preCheckoutGitUtilsSbt.sh")
 '(ensime-sbt-perform-on-save "compile")
 '(explicit-bash-args (quote ("--noediting" "-i" "-l")))
 '(package-selected-packages
   (quote
    (restclient magit omnisharp haskell-mode jdee ensime use-package yasnippet scala-mode2 scala-mode sbt-mode s popup pdf-tools dash company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; start up in full screen mode:
;;(toggle-frame-fullscreen)

;; to setup tabs -- always use spaces instead of tabs:
(setq c-basic-indent 4)
;;(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq-default indent-tabs-mode nil)

(setq inhibit-eol-conversion t)

;; Install pdf-tools:
;;(pdf-tools-install)

;; org mode:
(require 'org)
;;(define-key global-map "\C-cl" 'org-store-link)
;;(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
                           ("~/org/someday.org" :maxlevel . 1)
                           ("~/org/tickler.org" :maxlevel . 2)))

(setq org-agenda-files (list "~/org/inbox.org"
                             "~/org/gtd.org" 
                             "~/org/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(add-to-list 'exec-path "/usr/local/bin")

(use-package ensime
  :ensure t
  :pin melpa-stable)

(setq ensime-startup-notification nil)


;;(require 'ido)
;;(ido-mode t)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


;; C# support through OmniSharp:
(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun my-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)
  (setq inhibit-eol-conversion t)

  ;csharp-mode README.md recommends this too
  ;(electric-pair-mode 1)       ;; Emacs 24
  ;(electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c C-c") 'recompile))

(setq omnisharp-server-executable-path "/Users/bbunch/omnisharp-osx/run")
(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

;; Start emacs as a server:
(server-start)

;; Tramp config:
(setq auth-sources '("~/.ssh/.authinfo"))
