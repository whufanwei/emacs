;;; fan.el
;;
;; Copyright (c) 2017 欧阳威
;;
;; Version: 0.12
;; Keywords: funtion

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
(auto-compression-mode t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(global-hl-line-mode t)


;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers


(defvar fan-save-dir  "~/.saves")
(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" fan-save-dir))
(setq save-place t)

(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" fan-save-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15)
(recentf-mode t)

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      '(mark-ring
        global-mark-ring
        search-ring
        regexp-search-ring
        extended-command-history)
      enable-recursive-minibuffers t
      history-length 1000
      savehist-autosave-interval 60
      savehist-file (expand-file-name "savehist" fan-save-dir))
(savehist-mode t)


;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)

(use-package cal-china-x
  :commands cal-china-x-setup
  :init (add-hook 'calendar-load-hook #'cal-china-x-setup)
  :config
  (setq calendar-location-name "BEIJING"
        calendar-latitude 30.67
        calendar-longitude 104.06)
  
  ;; Holidays
  (setq calendar-mark-holidays-flag t)
  
  (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
  (setq cal-china-x-general-holidays
        '((holiday-lunar 1 15 "元宵节")
          (holiday-lunar 7 7 "七夕节")
          (holiday-fixed 3 8 "妇女节")
          (holiday-fixed 3 12 "植树节")
          (holiday-fixed 5 4 "青年节")
          (holiday-fixed 6 1 "儿童节")
          (holiday-fixed 9 10 "教师节")))
  (setq holiday-other-holidays
        '((holiday-fixed 2 14 "情人节")
          (holiday-fixed 4 1 "愚人节")
          (holiday-fixed 12 25 "圣诞节")
          (holiday-float 5 0 2 "母亲节")
          (holiday-float 6 0 3 "父亲节")
          (holiday-float 11 4 4 "感恩节")))
  (setq calendar-holidays
        (append cal-china-x-important-holidays
                cal-china-x-general-holidays
                holiday-other-holidays)))

(use-package lisp-mode
  :diminish eldoc-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode))

(use-package rainbow-delimiters
  :ensure t)

(use-package fix-word
  :bind
  (("M-u" . fix-word-upcase)
   ("M-l" . fix-word-downcase)
   ("M-c" . fix-word-capitalize)))


(provide 'fan-something)


