;;; fan.el
;;
;; Copyright (c) 2014 欧阳威
;;
;; Version: 0.12
;; Keywords: funtion

;; -------------------------------------------------------------------------------
;; 文件操作

;; 复制当前文件名
(defun prelude-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;; 文件重命名
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

;; 窗口切换
(defun prelude-swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (if (/= (count-windows) 2)
      (message "You need exactly 2 windows to do this.")
    (let* ((w1 (car (window-list)))
           (w2 (cadr (window-list)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2)))
      (set-window-buffer w1 b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)))
  (other-window 1))

;; 仅保留当前buffer。
(defun prelude-kill-other-buffers ()
  "Kill all buffers but the current one.
Doesn't mess with special buffers."
  (interactive)
  (-each
      (->> (buffer-list)
        (-filter #'buffer-file-name)
        (--remove (eql (current-buffer) it)))
    #'kill-buffer))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;-----------------------------------------------------

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;; ----------------------注释当前行------------------
(defun qiang-comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

(defun zl-delete-line nil
  "delete the whole line"
  (interactive)
  (beginning-of-line);光标移动到行首
  (push-mark);做个标记
  (beginning-of-line 2);移动到下一行行首
  (kill-region (point) (mark)));光标和标记之间的删掉

(global-set-key (kbd "C-k") 'zl-delete-line);删除一行

(defun zl-newline nil
  "open new line belowe current line"
  (interactive)
  (end-of-line)
  (newline))

(global-set-key  (kbd "C-z") 'zl-newline)

(defun zl-newline-up nil
  "open new line up current line"
  (interactive)
  (beginning-of-line)
  (newline)
  (backward-char))

(global-set-key  (kbd "C-q") 'zl-newline-up)

;; -------------------------临时记号---------------------------
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\;)] 'ska-jump-to-register)
(defun ska-point-to-register()
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

;; 搜索光标下字符串
(defun my-isearch-yank-word-or-char-from-beginning ()
  "Move to beginning of word before yanking word in isearch-mode."
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string))
      (beginning-of-thing 'word))
  (isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning
			     'isearch-yank-word-or-char
			     isearch-mode-map))
(add-hook 'isearch-mode-hook
	  (lambda ()
	    "Activate my customized Isearch word yank command."
	    (substitute-key-definition 'isearch-yank-word-or-char
				       'my-isearch-yank-word-or-char-from-beginning
				       isearch-mode-map)))

(provide 'fan)


