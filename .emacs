(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(fringe-mode (quote (4 . 4)) nil (fringe))
 '(indicate-empty-lines t)
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-table-auto-blank-field nil)
 '(package-selected-packages
   (quote
    (which-key diminish company-quickhelp aggressive-indent org beacon tangotango-theme dracula-theme company goto-last-change spaceline-all-the-icons spaceline browse-kill-ring fix-word rainbow-mode rainbow-delimiters cdlatex auctex ag magit projectile easy-kill flx-ido crux smex counsel swiper ivy elisp-slime-nav avy-zap avy iedit hungry-delete mwim use-package s paradox expand-region drag-stuff comment-dwim-2 cal-china-x auto-indent-mode anzu)))
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
;; (setq-default word-wrap t)
(setq-default auto-fill-function 'do-auto-fill)
(setq default-fill-column 80)
(setq default-major-mode 'org-mode)
(setq global-font-lock-mode t)
(setq auto-image-file-mode t)
(setq frame-title-format "%b")
(setq mouse-yank-at-point t)
(setq visible-bell t)
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default tab-width 2 indent-tabs-mode nil)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq ns-function-modifier 'hyper)

(toggle-frame-maximized)
(global-set-key (kbd "C-c e") 'eval-buffer)

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

(add-to-list 'load-path "~/emacs/extension" t)
(add-to-list 'load-path "~/.emacs.d/elpa" t)

(require 'package)
(setq package-archives '(("gnu"   .  "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))
(package-initialize)

(require 'fan-something)

(require 's)

(require 'use-package)


(use-package swiper
  :config
  (ivy-mode 1)
  (setq enable-recursive-minibuffers t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-c s") 'counsel-describe-function)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file))

(use-package counsel
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

;; (require 'key-chord)
;; (key-chord-mode 1)

;; ;;(require 'fancy-narrow)

;; (require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x r" "C-c"))
;; (guide-key-mode 1)
;; (setq guide-key/idle-delay 0.1)

;; (require 'keyfreq)
;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)

(use-package crux
  :bind (("C-k"   . crux-smart-kill-line)
         ("C-z"   . crux-smart-open-line)
         ("C-o"   . crux-smart-open-line-above)
         ("C-x f"  . crux-recentf-find-file)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-x C-r" . crux-rename-buffer-and-file)
         ("C-c t" . crux-visit-term-buffer)
         ("C-c k" . crux-kill-other-buffers)
         ("C-<backspace>" . crux-kill-line-backwards)
         ("C-a" . crux-move-beginning-of-line)))

(use-package avy
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-char-2)
         ("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-1)
         ("M-g e" . avy-goto-word-0))
  :init (add-hook 'after-init-hook #'avy-setup-default)
  :config (setq avy-background t))

;; Kill text between the point and the character CHAR
(use-package avy-zap
  :bind (("M-z" . avy-zap-to-char-dwim)))

(use-package hungry-delete
  :diminish hungry-delete-mode
  :init (add-hook 'after-init-hook #'global-hungry-delete-mode)
  :config (setq-default hungry-delete-chars-to-skip " \t\f\v"))

(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

(use-package drag-stuff
  :diminish drag-stuff-mode
  :init (add-hook 'after-init-hook #'drag-stuff-global-mode)
  :config
  (add-to-list 'drag-stuff-except-modes 'org-mode)
  (drag-stuff-define-keys))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package anzu
  :bind (("M-%" . anzu-query-replace)
         ("C-c r" . anzu-query-replace-regexp))
  :config
  (set-face-attribute 'anzu-mode-line nil
                      :foreground "blue" :weight 'bold)
  (global-anzu-mode)
  (setq anzu-cons-mode-line-p nil))

(use-package which-key
  :defer 10
  :config
  (progn
    (setq which-key-popup-type 'minibuffer)
    (setq which-key-compute-remaps t) ;Show correct descriptions for remapped keys
    (which-key-mode 1)))

(use-package goto-last-change
  :bind
  ("C-c l" . goto-last-change))

(use-package company
  :diminish company-mode
  :init (progn
          (add-hook 'after-init-hook 'global-company-mode)
          (setq company-dabbrev-ignore-case nil
                company-dabbrev-code-ignore-case nil
                company-dabbrev-downcase nil
                company-idle-delay 0
                company-begin-commands '(self-insert-command)
                company-transformers '(company-sort-by-occurrence))))

(use-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode 1)
  (setq beacon-push-mark 10))

(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :config (add-hook 'prog-mode-hook 'aggressive-indent-mode))

(use-package magit
  :ensure t
  :bind (("C-c m" . magit-status)))

(require 'fan-latex)


;; (require 'fan-org)
;; (require 'fan-keybinding)

(add-to-list 'custom-theme-load-path "~/emacs/color")
;; (load-theme 'tangotango t)
(load-theme 'dracula t)


(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-info-mode)
  (spaceline-emacs-theme))
