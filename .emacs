(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(indicate-empty-lines t)
 '(org-clock-mode-line-total (quote auto))
 '(org-clock-modeline-total (quote auto))
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-table-auto-blank-field nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "microsoft" :slant normal :weight normal :height 165 :width normal)))))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "WenQuanYi Micro Hei Mono" :size 24)))

;;M-x  eval-last-sexp 使.emacs中光标前的那一条语句立刻生效。
;;M-x  eval-region   使.emacs中选中的region中的语句立刻生效。
;;M-x  eval-buffer   使当前的buffer中的设置语句立刻生效。
;;M-x  load-file ~/.emacs  载入.emacs文件，从而使其中的设置生效。

(setq user-full-name "欧阳威")
(setq user-mail-address "whufanwei@gmail.com")
(setq track-eol t);; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq cua-enable-cua-keys nil) ;; only for rectangles
(setq x-select-enable-clipboard t)
(setq default-directory "/home/fan/")

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

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
(auto-compression-mode t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq auto-save-interval 20)
(setq auto-save-timeout 10)

(setq shell-file-name "/bin/bash")
(global-set-key (kbd "C-c z") 'shell)
(global-set-key (kbd "C-c e") 'eval-buffer)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c o") 'occur)

;; (global-set-key (kbd "C-c f") 'flush-lines)
(global-set-key (kbd "C-c k") 'keep-lines)
(global-set-key [f6] 'replace-regexp)
(global-set-key (kbd "C-c f") 'fill-individual-paragraphs)
(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-h a") 'apropos)
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(require 'windmove)
(windmove-default-keybindings)

;; 清理buffer
(require 'midnight)
(setq clean-buffer-list-delay-general 1)
(setq clean-buffer-list-delay-special (* 5 3600))
(setq midnight-period (* 2 60 60))
(setq clean-buffer-list-kill-regexps
      '("^.*"))
(defvar clean-buffer-list-kill-never-buffer-names-init
  clean-buffer-list-kill-never-buffer-names
  "Init value for clean-buffer-list-kill-never-buffer-names")
(setq clean-buffer-list-kill-never-buffer-names
      (append
       '("*Messages*" "*scratch*" "*w3m*" "*w3m-cache*")
       clean-buffer-list-kill-never-buffer-names-init))

;; 正则表达式匹配
(require 're-builder)
(setq reb-re-syntax 'string)
(global-set-key (kbd "C-c r") 're-builder)

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
(global-set-key (kbd "C-c \\") 'align-regexp)

;; (require 'ess-site)

;; buffer名称唯一
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(require 'saveplace)
(setq-default save-place t)
(desktop-save-mode 1)


(require 'hl-line)
(global-hl-line-mode t)

(require 'recentf)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(recentf-mode t)
(setq recentf-max-saved-items 50)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; (setq ido-enable-prefix nil)
;; (setq ido-enable-case nil)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode t)
;; (icomplete-mode t)

;; ------------------------------------------------------------------

(add-to-list 'load-path "~/emacs/extension" t)

(require 'fan)
(require 'fan-org)
(require 'fan-latex)

(add-to-list 'custom-theme-load-path "~/emacs/color" t)
(load-theme 'tangotango t)

;; (require 'ethan-wspace)
;; (global-ethan-wspace-mode 1)
;; (set-default 'ethan-wspace-errors (remove 'tabs ethan-wspace-errors))
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)


(require 'ido-ubiquitous)

(require 'elisp-slime-nav)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; (require 'ws-trim)
;; (global-ws-trim-mode t)
;; (set-default 'ws-trim-level 2)
;; (global-set-key (kbd "C-c t") 'ws-trim-buffer)

;; (require 'deft)
;; (setq deft-extension "org")
;; (setq deft-text-mode 'org-mode)
;; (setq deft-use-filename-as-title t)

(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-priority1-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-priority1-holidays)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (require 'cursor-chg)  ; Load this library
;; (change-cursor-mode 1) ; On for overwrite/read-only/input mode
;; (toggle-cursor-type-when-idle 1) ; On when idle

(setq auto-indent-on-visit-file t)
(require 'auto-indent-mode)
;; (auto-indent-global-mode)

;; (require 'goto-chg)
;; (global-set-key [f11] 'goto-last-change)

;; (require 'undo-tree)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'wrap-region)
(wrap-region-mode t)

(add-to-list 'load-path "~/emacs/extension/magit")
(require 'magit)
(global-set-key [f7] 'magit-status)

(add-to-list 'load-path "~/emacs/extension/smartparens")
(require 'smartparens-config)
(require 'smartparens-latex)
(smartparens-global-mode t)

(require 'smartparens-config)
(setq sp-autoskip-closing-pair 'always)
(setq sp-navigate-close-if-unbalanced t)
(smartparens-global-mode t)

;; highlights matching pairs
(show-smartparens-global-mode t)

;; keybinding management
(define-key sp-keymap (kbd "M-s f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "M-s b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "M-s d") 'sp-down-sexp)
(define-key sp-keymap (kbd "M-s D") 'sp-backward-down-sexp)
(define-key sp-keymap (kbd "M-s a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "M-s e") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "M-s u") 'sp-up-sexp)
;; (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
(define-key sp-keymap (kbd "M-s U") 'sp-backward-up-sexp)
(define-key sp-keymap (kbd "M-s t") 'sp-transpose-sexp)

(define-key sp-keymap (kbd "M-s n") 'sp-next-sexp)
(define-key sp-keymap (kbd "M-s p") 'sp-previous-sexp)

(define-key sp-keymap (kbd "M-s k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "M-s w") 'sp-copy-sexp)

(define-key sp-keymap (kbd "M-s s") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "M-s r") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "M-s S") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "M-s R") 'sp-backward-barf-sexp)
(define-key sp-keymap (kbd "M-s F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "M-s B") 'sp-backward-symbol)

(define-key sp-keymap (kbd "M-s [") 'sp-select-previous-thing)
(define-key sp-keymap (kbd "M-s ]") 'sp-select-next-thing)

(define-key sp-keymap (kbd "M-s M-i") 'sp-splice-sexp)
(define-key sp-keymap (kbd "M-s <delete>") 'sp-splice-sexp-killing-forward)
(define-key sp-keymap (kbd "M-s <backspace>") 'sp-splice-sexp-killing-backward)
(define-key sp-keymap (kbd "M-s M-<backspace>") 'sp-splice-sexp-killing-around)

(define-key sp-keymap (kbd "M-s M-d") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "M-s M-b") 'sp-backward-unwrap-sexp)

(define-key sp-keymap (kbd "M-s M-t") 'sp-prefix-tag-object)
(define-key sp-keymap (kbd "M-s M-p") 'sp-prefix-pair-object)
(define-key sp-keymap (kbd "M-s M-c") 'sp-convolute-sexp)
(define-key sp-keymap (kbd "M-s M-a") 'sp-absorb-sexp)
(define-key sp-keymap (kbd "M-s M-e") 'sp-emit-sexp)
(define-key sp-keymap (kbd "M-s M-p") 'sp-add-to-previous-sexp)
(define-key sp-keymap (kbd "M-s M-n") 'sp-add-to-next-sexp)
(define-key sp-keymap (kbd "M-s M-j") 'sp-join-sexp)
(define-key sp-keymap (kbd "M-s M-s") 'sp-split-sexp)
(define-key sp-keymap (kbd "M-s M-r") 'sp-raise-sexp)


(add-to-list 'load-path "~/emacs/extension/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(add-to-list 'load-path "~/emacs/extension/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-o") 'mc/edit-lines)

(require 'diminish)
(diminish 'wrap-region-mode)
(diminish 'projectile-mode)
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))
(add-hook 'emacs-lisp-mode-hook 
          (lambda()
            (setq mode-name "EL"))) 

;; (add-to-list 'load-path "~/emacs/extension/helm")
;; (require 'helm-config)
;; (helm-mode t)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-x c g") 'helm-do-grep)
;; (global-set-key (kbd "C-x c o") 'helm-occur)


(add-to-list 'load-path "~/emacs/extension/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/usr/share/dict/words")
;; (add-to-list 'ac-dictionary-directories "~/emacs/ac-dict")
(ac-config-default)
;; 模糊匹配，Fuzzy Matching
(define-key ac-mode-map (kbd "M-RET") 'auto-complete)
;; Show 0.2 second later
(setq ac-auto-show-menu 0.2)
(setq-default ac-sources '(ac-source-semantic
                           ;;ac-source-yasnippet
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
(global-set-key (kbd "M-/") 'ac-complete-words-in-all-buffer)
;; (global-set-key (kbd "C-M-/") 'dabbrev-completion)

;; (setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
;; (setq ispell-dictionary "english") ; y language your spell-checking program supports

;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)


(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)

(setq
 mu4e-maildir       "~/Maildir"   ;; top-level Maildir
 mu4e-sent-folder   "/sent"       ;; folder for sent messages
 mu4e-drafts-folder "/drafts"     ;; unfinished messages
 mu4e-trash-folder  "/trash"      ;; trashed messages
 mu4e-refile-folder "/archive")   ;; saved messages

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-view-prefer-html t)
(setq mu4e-html2text-command
      "html2markdown | grep -v '&nbsp_place_holder;'")
