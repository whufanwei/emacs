;;; fan.el
;;
;; Copyright (c) 2012 欧阳威
;;
;; Version: 0.1
;; Keywords: funtion

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    ;; restore point to original column in moved line
    (insert line-text)
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)


;; 高级复制

(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )
(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  ;; (paste-to-mark arg)
  )

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
  ;; (paste-to-mark arg)
  )

(defun beginning-of-parenthesis(&optional arg)
  "  "
  (re-search-backward "[[<(?\"]" (line-beginning-position) 3 1)
  (if (looking-at "[[<(?\"]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-parenthesis(&optional arg)
  " "
  (re-search-forward "[]>)?\"]" (line-end-position) 3 arg)
  (if (looking-back "[]>)?\"]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-parenthesis-to-mark(&optional arg)
  " Try to copy a parenthesis and paste it to the mark
     When used in shell-mode, it will paste parenthesis on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
  )

(global-set-key (kbd "C-c p") (quote thing-copy-parenthesis-to-mark))
(global-set-key (kbd "C-c w") (quote copy-word))
(global-set-key (kbd "C-c l") (quote copy-line))

;; 窗口切换
(defun toggle-window-split ()
  "Vertical split shows more of each line, horizontal split shows
more lines. This code toggles between them. It only works for
frames with exactly two windows."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(global-set-key [(control x) (t)] 'toggle-window-split)

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

;; -----------------------------结束--------------------------------
(defun delete-enclosed-text ()
  "Delete texts between any pair of delimiters."
  (interactive)
  (save-excursion
    (let (p1 p2)
      (skip-chars-backward "^([<>'‘“\"") (setq p1 (point))
      (skip-chars-forward "^)]<>'’”\"") (setq p2 (point))
      (delete-region p1 p2))))
(global-set-key (kbd "C-M-d") 'delete-enclosed-text);;删除括号内的内容。
;; (global-set-key (kbd "C-M-d") 'delete-pair);;删除括号。

(defun joseph-jump-to-space-forward()
  (interactive)
  (let ((old-pos (point))
	m-end m-begin
	)
    (when (re-search-forward "[ \t]+"  nil t)
      (setq m-begin (match-beginning 0))
      (setq m-end (match-end 0))
      (goto-char m-begin)
      (if (equal old-pos m-end)
	  (progn
	    (re-search-forward "[ \t]+"  nil t)
	    (goto-char (match-beginning 0)))
	(if (equal m-begin old-pos)
	    (goto-char m-end)
	  )))))
;; (global-set-key (kbd "C-o") 'joseph-jump-to-space-forward);;跳到下一处空格

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
