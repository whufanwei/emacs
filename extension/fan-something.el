;;; fan.el
;;
;; Copyright (c) 2012 欧阳威
;;
;; Version: 0.1
;; Keywords: funtion


;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
(auto-compression-mode t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

;; (setq backup-directory-alist `(("." . "~/.saves")))
;; (setq backup-by-copying t)
;; (setq delete-old-versions t
;;       kept-new-versions 6
;;       kept-old-versions 2
;;       version-control t)
;; (setq auto-save-interval 20)
;; (setq auto-save-timeout 10)

(require 'hl-line)
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
(setq-default save-place t)

(require 'recentf)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
(setq recentf-save-file (expand-file-name "recentf" fan-save-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15)
(recentf-mode +1)

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" fan-save-dir))
(savehist-mode +1)

;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)


(defun prelude-rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(provide 'fan-something)


