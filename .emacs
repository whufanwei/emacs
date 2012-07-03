(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(org-clock-modeline-total (quote auto))
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-table-auto-blank-field nil)
 ;; '(reftex-default-bibliography (quote ("~/文档/dalunwen/body/reference")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#2e3434" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 181 :width normal :foundry "unknown" :family "Ubuntu Mono")))))

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

(setq enable-recursive-minibuffers t)
(setq-default word-wrap t)
(setq-default auto-fill-function 'do-auto-fill)
(setq default-fill-column 100)
(setq default-major-mode 'org-mode)
(setq global-font-lock-mode t)
(setq auto-image-file-mode t)
(setq frame-title-format "%b")
(setq mouse-yank-at-point t)
(setq visible-bell t)
(global-visual-line-mode 1)
(prefer-coding-system 'utf-8)

;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "127.0.0.1:8086")))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

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

(setq shell-file-name "/bin/zsh")
(global-set-key (kbd "C-c z") 'shell)

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-c f") 'flush-lines)
(global-set-key (kbd "C-c k") 'keep-lines)
(global-set-key [f6] 'replace-regexp)

;; maxima字体设定
(setq imaxima-fnt-size "huge")
(setq imaxima-use-maxima-mode-flag t)

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
(global-set-key (kbd "C-x j") 'align-regexp)

(require 'ess-site)

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

(require 'python)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; ------------------------------------------------------------------

(add-to-list 'load-path "~/emacs/extension" t)

(require 'fan)
(require 'fan-org)
(require 'fan-latex)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'highlight-symbol)
(global-set-key (kbd "<f9> h") 'highlight-symbol-at-point)
(global-set-key (kbd "<f9> n") 'highlight-symbol-next)
;; (global-set-key (kbd "<f9> r") 'highlight-symbol-query-replace)
(global-set-key (kbd "<f9> p") 'highlight-symbol-prev)

(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-priority1-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-priority1-holidays)

(require 'cursor-chg)  ; Load this library
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle

(require 'auto-indent-mode)
(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
(auto-indent-global-mode)

(require 'goto-chg)
(global-set-key [f11] 'goto-last-change)

(require 'undo-tree)

(require 'ediff+)

(require 'textmate)
(tm/initialize)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(require 'jump-char)
(global-set-key (kbd "C-j") 'jump-char-forward)
;; (global-set-key (kbd "C-S j") 'jump-char-backward)
(global-set-key [(shift control j)] 'jump-char-backward)

(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(add-to-list 'load-path "~/emacs/helm")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "<f9> l") 'helm-locate)
(global-set-key (kbd "<f9> g") 'helm-do-grep)
(helm-dired-bindings 1)

(add-to-list 'load-path "~/emacs/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs/auto-complete/dict")
(ac-config-default)
;; 模糊匹配，Fuzzy Matching
(define-key ac-mode-map (kbd "M-RET") 'auto-complete)
;; Show 0.2 second later
(setq ac-auto-show-menu 0.2)
(setq-default ac-sources '(ac-source-yasnippet
                           ac-source-semantic
                           ac-source-ropemacs
                           ac-source-imenu
			   ac-source-files-in-current-dir
                           ac-source-words-in-buffer
                           ac-source-words-in-all-buffer
                           ac-source-dictionary
			   ac-source-functions
                           ac-source-abbrev
                           ac-source-files-in-current-dir
                           ac-source-filename))
(setq ac-auto-start 2)
(setq ac-dwim t)
(setq global-auto-complete-mode t)

(add-to-list 'load-path "~/emacs/extension/magit")
(require 'magit)
(global-set-key [f7] 'magit-status)


(add-to-list 'load-path "~/emacs/extension/color")
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-tangotango)

(add-to-list 'load-path "~/emacs/extension/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(add-to-list 'load-path "~/emacs/extension/yasnippet")
(require 'yasnippet)
(setq yas/snippet-dirs "~/emacs/extension/yasnippet/snippets")
(yas/global-mode 1)

(add-to-list 'load-path "~/emacs/extension/inf-ruby")
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-keys))


(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

