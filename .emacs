(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(fringe-mode (quote (4 . 4)) nil (fringe))
 '(indicate-empty-lines t)
 ;; '(org-clock-mode-line-total (quote auto))
 ;; '(org-clock-modeline-total (quote auto))
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-table-auto-blank-field nil)
 '(safe-local-variable-values (quote ((emacs-lisp-docstring-fill-column . 75))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(set-face-attribute
 'default nil :font "Monaco 20")

;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset
;;                     (font-spec :family "Heiti SC" :size 22)))

;;M-x  eval-last-sexp 使.emacs中光标前的那一条语句立刻生效。
;;M-x  eval-region   使.emacs中选中的region中的语句立刻生效。
;;M-x  eval-buffer   使当前的buffer中的设置语句立刻生效。
;;M-x  load-file ~/.emacs  载入.emacs文件，从而使其中的设置生效。

(setq user-full-name "欧阳威")
(setq user-mail-address "whufanwei@gmail.com")
(setq track-eol t);; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq cua-enable-cua-keys nil) ;; only for rectangles
(setq x-select-enable-clipboard t)
(setq default-directory "~/")

(display-time-mode 1)
(setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq kill-ring-max 200)
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\(\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(show-paren-mode t)
(column-number-mode 1)
(size-indication-mode 1)
(setq enable-recursive-minibuffers t)
(setq-default word-wrap t)
(setq-default auto-fill-function 'do-auto-fill)
(setq default-fill-column 80)
(setq default-major-mode 'org-mode)
(setq global-font-lock-mode t)
(setq auto-image-file-mode t)
(setq frame-title-format "%b")
(setq mouse-yank-at-point t)
(setq visible-bell t)
(global-visual-line-mode 1)
(setq-default tab-width 2 indent-tabs-mode nil)
;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "127.0.0.1:8086")))
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; 清理buffer
(require 'midnight)
(setq clean-buffer-list-delay-general 1)
(setq clean-buffer-list-delay-special (* 5 3600))
(setq midnight-period (* 2 60 60))
(setq clean-buffer-list-kill-regexps
      '("^.*"))

;; 正则表达式匹配
(require 're-builder)
(setq reb-re-syntax 'string)
;; (global-set-key (kbd "C-c r") 're-builder)

;; 使用root账户打开文件
(require 'tramp)
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
(global-set-key (kbd "<f9> r") 'sudo-find-file)

;; 实现程序变量得自动对齐
(require 'align)


;; ------------------------------------------------------------------

(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path)) 

(require 'package)
(setq package-archives '(
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

(add-to-list 'load-path "~/emacs/extension" t)

(require 'auto-indent-mode)
(auto-indent-global-mode)

(defun prelude-add-subfolders-to-load-path (parent-dir)
 "Add all level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
                (not (equal f ".."))
                (not (equal f ".")))
       (add-to-list 'load-path name)
       (prelude-add-subfolders-to-load-path name)))))

(defvar elpa-dir  "~/emacs/elpa/")
(prelude-add-subfolders-to-load-path  elpa-dir)

(defvar melpa-dir  "~/.emacs.d/elpa/")
(prelude-add-subfolders-to-load-path  melpa-dir)


(require 'fan)
(require 'fan-osx)
(require 'fan-something)

(require 's)

;; (require 'git)
(require 'use-package)

(use-package flx-ido
  :init (flx-ido-mode 1)
  :config
  (progn
    (ido-mode 1)
    (ido-everywhere 1)
    (flx-ido-mode 1)
    (setq ido-enable-flex-matching t)
    ;; (setq ido-use-kface nil)
    )
  )

(require 'ido-vertical-mode)
(ido-vertical-mode)

(setq ido-decorations
      '("\n-> " "" "\n " "\n ..." "[" "]"
        " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package smex
  :config (smex-initialize)
  :bind ("M-x" . smex))

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))

(use-package projectile
  :init (projectile-global-mode 1)
  :config
  (progn
    (setq projectile-enable-caching t)
    (setq projectile-require-project-root nil)
    (setq projectile-completion-system 'ido)
    (add-to-list 'projectile-globally-ignored-files ".DS_Store")))

(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/emacs/elpa/magit-master")))

(use-package magit
  :init
  (progn
    (use-package magit-blame)
    (bind-key "C-c C-a" 'magit-just-amend magit-mode-map))
  :config
  (progn
    (setq magit-default-tracking-name-function 'magit-default-tracking-name-branch-only)
    (setq magit-set-upstream-on-push t)
    (setq magit-completing-read-function 'magit-ido-completing-read)
    (setq magit-stage-all-confirm nil)
    (setq magit-unstage-all-confirm nil)
    (setq magit-restore-window-configuration t))
  :bind ("C-c m" . magit-status))

(use-package git-timemachine)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package markdown-mode
  :mode (("\\.markdown$" . markdown-mode)
         ("\\.md$" . markdown-mode)))

(use-package ack-and-a-half
  :init
  (progn
    (defalias 'ack 'ack-and-a-half)
    (defalias 'ack-same 'ack-and-a-half-same)
    (defalias 'ack-find-file 'ack-and-a-half-find-file)
    (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)))

(use-package smartparens
  :init
  (progn
    (use-package smartparens-config)
    (use-package smartparens-latex)
    (use-package smartparens-html)
    (smartparens-global-mode 1)
    (show-smartparens-global-mode 1))
  :config
  (progn
    (setq smartparens-strict-mode t)
    (setq sp-autoinsert-if-followed-by-word t)
    (sp-local-pair 'emacs-lisp-mode "`" nil :when '(sp-in-string-p))
    (sp-local-tag '(sgml-mode html-mode rhtml-mode) "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))
   )

(use-package exec-path-from-shell
  :init
  (progn
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))))

(use-package rainbow-delimiters
  :init (global-rainbow-delimiters-mode))

(require 'dired-details)

(require 'hungry-delete)
(global-hungry-delete-mode)

(require 'key-chord)
(key-chord-mode 1)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/usr/share/dict/words")
;; (add-to-list 'ac-dictionary-directories "~/emacs/ac-dict")
(ac-config-default)
;; Show 0.2 second later
(setq ac-auto-show-menu 0.2)
(setq-default ac-sources '(ac-source-semantic
                           ac-source-ropemacs
                           ac-source-variables
                           ac-source-imenu
                           ac-source-files-in-current-dir
                           ac-source-words-in-buffer
                           ac-source-words-in-all-buffer
                           ac-source-dictionary
                           ac-source-functions
                           ac-source-abbrev
                           ac-source-filename))
(setq ac-auto-start 2)
(setq ac-dwim t)
(global-auto-complete-mode t)

(require 'ace-jump-buffer)

(require 'fancy-narrow)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-c"))
(guide-key-mode 1)
(setq guide-key/idle-delay 0.1)

(require 'elisp-slime-nav)
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'turn-on-elisp-slime-nav-mode))

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'diminish)
(diminish 'projectile-mode)
(diminish 'guide-key-mode)
;;(diminish 'elisp-slime-nav)
(add-hook 'emacs-lisp-mode-hook 
          (lambda()
            (setq mode-name "EL"))) 

(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-important-holidays)

(require 'anzu)
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "blue" :weight 'bold)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-to-string-separator " => "))

(require 'goto-chg)


(require 'easy-kill)

(require 'powerline)
(setq powerline-arrow-shape 'arrow)   ;; the default

(require 'fan-org)
(require 'fan-latex)
(require 'fan-keybinding)

(add-to-list 'custom-theme-load-path "~/emacs/color")
(load-theme 'tangotango t)
