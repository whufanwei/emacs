(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "xelatex -shell-escape")
 '(TeX-command "xelatex -shell-escape")
 '(TeX-engine (quote xetex))
 '(TeX-master nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(org-agenda-files (quote ("~/git/org/org.org" "/home/fan/git/org/refile.org")))
 '(org-clock-modeline-total (quote auto))
 '(org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 7:00") ("STYLE_ALL" . "habit"))))
 '(org-table-auto-blank-field nil)
 '(reftex-default-bibliography (quote ("~/下载/DLUT-git/body/reference")))
 '(safe-local-variable-values (quote ((TeX-master . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2e3434" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 181 :width normal :foundry "unknown" :family "Ubuntu Mono")))))

;;M-x  eval-last-sexp 使.emacs中光标前的那一条语句立刻生效。
;;M-x  eval-region   使.emacs中选中的region中的语句立刻生效。
;;M-x  eval-buffer   使当前的buffer中的设置语句立刻生效。
;;M-x  load-file ~/.emacs  载入.emacs文件，从而使其中的设置生效。


(setq user-full-name "whufanwei")
(setq user-mail-address "whufanwei@gmail.com")
(setq track-eol t);; 当光标在行尾上下移动的时候，始终保持在行尾。

(require 'midnight)
;; clean buffers open longer than 1 days
(setq clean-buffer-list-delay-general 1)
;; special buffers are cleaned every 5 hours
(setq clean-buffer-list-delay-special (* 5 3600))
;; run the midnight hook every 2 hours
(setq midnight-period (* 2 60 60))
(setq clean-buffer-list-kill-regexps
      '("^.*$"))
(defvar clean-buffer-list-kill-never-buffer-names-init
  clean-buffer-list-kill-never-buffer-names
  "Init value for clean-buffer-list-kill-never-buffer-names")
(setq clean-buffer-list-kill-never-buffer-names
      (append
       '("*Messages*" "*scratch*" "*w3m*" "*w3m-cache*")
       clean-buffer-list-kill-never-buffer-names-init))

(require 're-builder)
(setq reb-re-syntax 'string)
(global-set-key "\C-cr" 're-builder)

(defun eval-and-replace (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (format "%S" value)))
(global-set-key "\C-ce" 'eval-and-replace)

;; 实现程序变量得自动对齐
(require 'align)
(global-set-key "\C-xj" 'align-regexp)

(global-visual-line-mode 1)
;; (global-auto-revert-mode 1)
;; (require 'linum);;行号
;; (global-linum-mode t)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq shell-file-name "/bin/bash")
(global-set-key (kbd "C-c z") 'shell)

(require 'ess-site)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(prefer-coding-system 'utf-8)

(require 'saveplace)
(setq-default save-place t)
(desktop-save-mode 1)

(require 'hl-line)
(global-hl-line-mode t)

(require 'python)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs/extension/ac-dict")
(ac-config-default)
;; 模糊匹配，Fuzzy Matching
(define-key ac-mode-map (kbd "M-RET") 'auto-complete)
;; Show 0.2 second later
(setq ac-auto-show-menu 0.2)
(setq-default ac-sources '(ac-source-yasnippet    
                           ac-source-semantic  
                           ac-source-ropemacs  
                           ac-source-imenu    
                           ac-source-words-in-buffer
                           ac-source-words-in-all-buffer
                           ac-source-dictionary  
                           ac-source-abbrev
                           ac-source-files-in-current-dir    
                           ac-source-filename))   
(setq ac-auto-start 2) 
(global-auto-complete-mode t)

(setq cua-enable-cua-keys nil) ;; only for rectangles

(setq x-select-enable-clipboard t)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq default-directory "/home/fan/")

(ido-mode t)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(setq visible-bell t)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq kill-ring-max 200)

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(setq enable-recursive-minibuffers t)

(setq-default auto-fill-function 'do-auto-fill)
(setq default-fill-column 100)
(setq default-major-mode 'org-mode)

(setq frame-title-format "%b")

(setq auto-image-file-mode t)

(setq global-font-lock-mode t)

(setq-default word-wrap t)

(setq-default make-backup-files nil)

(setq auto-save-interval 20)
(setq auto-save-timeout 10)

;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "127.0.0.1:8086")))

(setq mouse-yank-at-point t)
;; (setq time-stamp-active t)
;; (setq time-stamp-warn-inactive t)
;; (setq time-stamp-format "%:y-m-d : H:M:S chunyu")

(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-c f") 'flush-lines)
(global-set-key (kbd "C-c k") 'keep-lines)

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

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
         (lambda()
           (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
            nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))

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
  ;; (paste-to-mark arg)
  )

(global-set-key (kbd "C-c p")         (quote thing-copy-parenthesis-to-mark))
(global-set-key (kbd "C-c w")         (quote copy-word))
(global-set-key (kbd "C-c l")         (quote copy-line))

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

(global-set-key [f6] 'replace-regexp)

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
(global-set-key (kbd "C-o") 'joseph-jump-to-space-forward);;跳到下一处空格

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

;; -----------------------------------------------------
(add-to-list 'load-path "~/emacs/extension/auctex" t)
(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)
(load "tex-site.el" nil t t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;(setq preview-scale-function 1.5)
(setq LaTeX-math-mode t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-AUCTeX t)
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-toc-split-windows-horizontally t) ;;*toc*buffer在左侧。
(setq reftex-toc-split-windows-fraction 0.2)  ;;*toc*buffer 使用整个frame的比例。
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)  
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)

;;;;;;;;;LaTex-mode settings;;;;;
(add-hook 'LaTeX-mode-hook (lambda ()
			     (LaTeX-math-mode 1)
			     (setq TeX-show-compilation nil)   ;;NOT display compilation 
			     (setq TeX-global-PDF-mode t       ;;PDF mode enable, not plain
				   TeX-engine 'xetex)  ;;use xelatex default
			     (setq TeX-clean-confirm nil)
			     (imenu-add-menubar-index)
			     (setq TeX-save-query nil)
			     (setq TeX-show-compilation t)
			     (setq TeX-electric-escape t)      ;; 按 \ 后光标跳到mini-buffer
			     (setq TeX-view-program-list '(("Evince" "evince %o"))) ;;重新定义
			     (setq TeX-view-program-selection '((output-pdf "Evince")))
			     (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode) -shell-escape%' %t" TeX-run-TeX nil t))
			     (setq TeX-command-default "XeLaTeX")
			     ;;定义latex-mode下的快捷键
			     (define-key LaTeX-mode-map (kbd "C-c C-p") 'reftex-parse-all)
			     (setq LaTeX-section-hook
				   '(LaTeX-section-heading
				     LaTeX-section-title
				     ;;LaTeX-section-toc
				     LaTeX-section-section
				     LaTeX-section-label))))

;; --------------------------
(add-to-list 'load-path "~/emacs/extension" t)

(require 'highlight-symbol)
(global-set-key (kbd "<f9> h") 'highlight-symbol-at-point)
(global-set-key (kbd "<f9> n") 'highlight-symbol-next)
(global-set-key (kbd "<f9> r") 'highlight-symbol-query-replace)
(global-set-key (kbd "<f9> p") 'highlight-symbol-prev)

(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of {{{latex-mode}}}
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources)))
(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

(require 'autopair)
(setq autopair-autowrap t)
(add-hook 'LaTeX-mode-hook
	  #'(lambda ()
	      (push '(?< . ?>)
		    (getf autopair-extra-pairs :code))))

(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-priority1-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-priority1-holidays)

(require 'cursor-chg)  ; Load this library
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle

(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
(require 'auto-indent-mode)
(auto-indent-global-mode)

(require 'goto-chg)
(global-set-key [f11] 'goto-last-change)

(require 'dired-details+)

(require 'fullscreen)

(require 'undo-tree)

(require 'shell-command)
(shell-command-completion-mode)

(require 'ediff+)

(require 'textmate)
(tm/initialize)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(require 'jump-char)
(global-set-key (kbd "C-j") 'jump-char-forward)
;; (global-set-key (kbd "C-S j") 'jump-char-backward)
(global-set-key [(shift control j)] 'jump-char-backward)

(add-to-list 'load-path "~/emacs/helm")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "<f9> l") 'helm-locate)
(global-set-key (kbd "<f9> g") 'helm-do-grep)
(helm-dired-bindings 1)


(add-to-list 'load-path "~/emacs/extension/magit")
(require 'magit)
(global-set-key [f7] 'magit-status)

(add-to-list 'load-path "~/emacs/extension/nav")
(require 'nav)

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

(add-to-list 'load-path "~/emacs/extension/sunrise-commander")
(require 'sunrise-commander)


(add-to-list 'load-path (expand-file-name "~/emacs/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/emacs/org-mode/contrib/lisp"))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.\\(org\\  |org_archive\\|txt\\)$" . org-mode))
(require 'org-habit)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq system-time-locale "C")
(setq org-agenda-ndays 1)

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
	  (lambda ()
	    (make-variable-buffer-local 'yas/trigger-key)
	    (setq yas/trigger-key [tab])
	    (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
	    (define-key yas/keymap [tab] 'yas/next-field)))


(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key nil)
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
;; (setq auto-save-default nil)
;; Auto-saving does not cooperate with org-crypt.el: so you need
;; to turn it off if you plan to use org-crypt.el quite often.
(setq org-crypt-disable-auto-save nil)

(setq org-agenda-files (quote ("~/git/org/*.org")))
(setq org-default-notes-file "~/git/org/refile.org")

(global-set-key (kbd "C-c d") 'org-decrypt-entry)
(global-set-key (kbd "C-c i") 'org-clock-in)
(global-set-key (kbd "<f8>") 'org-clock-goto)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> i") 'bh/punch-in)
(global-set-key (kbd "<f9> o") 'bh/punch-out)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(define-key org-mode-map (kbd "C-k") 'zl-delete-line);删除一行
;; (define-key org-mode-map (kbd "C-,") 'goto-last-change);删除一行
(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key org-mode-map "\C-a" 'move-beginning-of-line)
	    (define-key org-mode-map "\C-e" 'move-end-of-line)))



(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/@)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("STARTED" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold)
	      ("PHONE" :foreground "forest green" :weight bold))))

(setq org-tag-alist (quote ((:startgroup)
			    ("@office" . ?o)
			    ("@home" . ?H)
			    (:endgroup)
			    ("PHONE" . ?p)
			    ("WAITING" . ?w)
			    ("HOLD" . ?h)
			    ("PERSONAL" . ?P)
			    ("crypt" . ?e)
			    ("WORK" . ?W)
			    ("NOTE" . ?n)
			    ("CANCELLED" . ?c)
			    )))

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/git/org/refile.org")
	       "* TODO %?\n%U\n%a\n  %i" :clock-in t :clock-resume t)
	      ("n" "note" entry (file "~/git/org/refile.org")
	       "* %? :NOTE:\n%U\n%a\n  %i" :clock-in t :clock-resume t)
	      ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
	       "* %?\n%U\n  %i" :clock-in t :clock-resume t)
	      ("w" "org-protocol" entry (file "~/git/org/refile.org")
	       "* TODO Review %c\n%U\n  %i" :immediate-finish t)
	      ("p" "Phone call" entry (file "~/git/org/refile.org")
	       "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
	      ("h" "Habit" entry (file "~/git/org/refile.org")
	       "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n  %i"))))


(setq org-refile-targets (quote ((nil :maxlevel . 9)
				 (org-agenda-files :maxlevel . 9))))
(setq org-refile-use-outline-path nil)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (let ((has-subtask)
	(subtree-end (save-excursion (org-end-of-subtree t)))
	(is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (forward-line 1)
      (while (and (not has-subtask)
		  (< (point) subtree-end)
		  (re-search-forward "^\*+ " subtree-end t))
	(when (member (org-get-todo-state) org-todo-keywords-1)
	  (setq has-subtask t))))
    (and is-a-task has-subtask)))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
			      (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
	  nil
	t))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
	(is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
	(when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
	  (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (let* ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
	 (subtree-end (save-excursion (org-end-of-subtree t)))
	 (has-next (save-excursion
		     (forward-line 1)
		     (and (< (point) subtree-end)
			  (re-search-forward "^\\*+ \\(NEXT\\|STARTED\\) " subtree-end t)))))
    (if (and (bh/is-project-p) (not has-next))
	nil ; a stuck project, has subtasks but no next task
      next-headline)))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (bh/is-project-p)
	nil
      subtree-end)))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (cond
     ((bh/is-project-p)
      subtree-end)
     ((org-is-habit-p)
      subtree-end)
     (t
      nil))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
	   (next-headline (save-excursion (or (outline-next-heading) (point-max))))
	   (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
	next-headline)
       ((org-is-habit-p)
	subtree-end)
       ((and (not limit-to-project)
	     (bh/is-project-subtree-p))
	subtree-end)
       ((and limit-to-project
	     (bh/is-project-subtree-p)
	     (member (org-get-todo-state) (list "NEXT")))
	subtree-end)
       (t
	nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (cond
     ((bh/is-project-p)
      next-headline)
     ((org-is-habit-p)
      next-headline)
     (t
      nil))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
	nil
      next-headline)))


;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
	       ((org-agenda-overriding-header "Notes")
		(org-tags-match-list-sublevels t)))
	      ("h" "Habits" tags-todo "STYLE=\"habit\""
	       ((org-agenda-overriding-header "Habits")
		(org-agenda-sorting-strategy
		 '(todo-state-down effort-up category-keep))))
	      (" " "Agenda"
	       ((agenda "" nil)
		(tags "REFILE"
		      ((org-agenda-overriding-header "Tasks to Refile")
		       (org-tags-match-list-sublevels nil)))
		(tags-todo "-CANCELLED/!"
			   ((org-agenda-overriding-header "Stuck Projects")
			    (org-tags-match-list-sublevels 'indented)
			    (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
		(tags-todo "-WAITING-CANCELLED/!NEXT|STARTED"
			   ((org-agenda-overriding-header "Next Tasks")
			    (org-agenda-skip-function 'bh/skip-projects-and-habits)
			    (org-agenda-todo-ignore-scheduled t)
			    (org-agenda-todo-ignore-deadlines t)
			    (org-tags-match-list-sublevels t)
			    (org-agenda-sorting-strategy
			     '(todo-state-down effort-up category-keep))))
		(tags-todo "-REFILE-CANCELLED/!-NEXT-STARTED-WAITING"
			   ((org-agenda-overriding-header "Tasks")
			    (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
			    (org-agenda-todo-ignore-scheduled t)
			    (org-agenda-todo-ignore-deadlines t)
			    (org-agenda-sorting-strategy
			     '(category-keep))))
		(tags-todo "-CANCELLED/!"
			   ((org-agenda-overriding-header "Projects")
			    (org-agenda-skip-function 'bh/skip-non-projects)
			    (org-tags-match-list-sublevels 'indented)
			    (org-agenda-todo-ignore-scheduled 'future)
			    (org-agenda-todo-ignore-deadlines 'future)
			    (org-agenda-sorting-strategy
			     '(category-keep))))
		(todo "WAITING|HOLD"
		      ((org-agenda-overriding-header "Waiting and Postponed tasks")
		       (org-agenda-skip-function 'bh/skip-projects-and-habits)
		       (org-agenda-todo-ignore-scheduled t)
		       (org-agenda-todo-ignore-deadlines t)))
		(tags "-REFILE/"
		      ((org-agenda-overriding-header "Tasks to Archive")
		       (org-agenda-skip-function 'bh/skip-non-archivable-tasks))))
	       nil)
	      ("r" "Tasks to Refile" tags "REFILE"
	       ((org-agenda-overriding-header "Tasks to Refile")
		(org-tags-match-list-sublevels nil)))
	      ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
	       ((org-agenda-overriding-header "Stuck Projects")
		(org-tags-match-list-sublevels 'indented)
		(org-agenda-skip-function 'bh/skip-non-stuck-projects)))
	      ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT|STARTED"
	       ((org-agenda-overriding-header "Next Tasks")
		(org-agenda-skip-function 'bh/skip-projects-and-habits)
		(org-agenda-todo-ignore-scheduled t)
		(org-agenda-todo-ignore-deadlines t)
		(org-tags-match-list-sublevels t)
		(org-agenda-sorting-strategy
		 '(todo-state-down effort-up category-keep))))
	      ("R" "Tasks" tags-todo "-REFILE-CANCELLED/!-NEXT-STARTED-WAITING"
	       ((org-agenda-overriding-header "Tasks")
		(org-agenda-skip-function 'bh/skip-project-tasks-maybe)
		(org-agenda-sorting-strategy
		 '(category-keep))))
	      ("p" "Projects" tags-todo "-CANCELLED/!"
	       ((org-agenda-overriding-header "Projects")
		(org-agenda-skip-function 'bh/skip-non-projects)
		(org-tags-match-list-sublevels 'indented)
		(org-agenda-todo-ignore-scheduled 'future)
		(org-agenda-todo-ignore-deadlines 'future)
		(org-agenda-sorting-strategy
		 '(category-keep))))
	      ("w" "Waiting Tasks" todo "WAITING|HOLD"
	       ((org-agenda-overriding-header "Waiting and Postponed tasks"))
	       (org-agenda-skip-function 'bh/skip-projects-and-habits)
	       (org-agenda-todo-ignore-scheduled 'future)
	       (org-agenda-todo-ignore-deadlines 'future))
	      ("A" "Tasks to Archive" tags "-REFILE/"
	       ((org-agenda-overriding-header "Tasks to Archive")
		(org-agenda-skip-function 'bh/skip-non-archivable-tasks))))))

;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
;; Small windows on my Eee PC displays only the end of long lists which isn't very useful
(setq org-clock-history-length 10)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task to STARTED when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-started)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist (quote history))
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-started (kw)
  "Switch task from TODO or NEXT to STARTED when clocking in.
Skips capture tasks."
  (if (and (member (org-get-todo-state) (list "TODO" "NEXT"))
	   (not (and (boundp 'org-capture-mode) org-capture-mode)))
      "STARTED"))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (let ((parent-task (save-excursion (org-back-to-heading) (point))))
    (while (org-up-heading-safe)
      (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
	(setq parent-task (point))))
    (goto-char parent-task)
    parent-task))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
	     (tags (org-with-point-at marker (org-get-tags-at))))
	(if (and (eq arg 4) tags)
	    (org-agenda-clock-in '(16))
	  (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ;; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
	  (org-clock-in '(16))
	(bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
	(widen)
	(while (and (not parent-task) (org-up-heading-safe))
	  (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
	    (setq parent-task (point))))
	(if parent-task
	    (org-with-point-at (or parent-task)
	      (org-clock-in))
	  (when bh/keep-clock-running
	    (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find bh/organization-task-id 'marker)
      (org-clock-in '(16)))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
	     (not org-clock-clocking-in)
	     (marker-buffer org-clock-default-task)
	     (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)


(require 'org-id)  
(defun bh/clock-in-task-by-id (id)
  "Clock in a task by id"
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find id 'marker)
      (org-clock-in nil))))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
	 (cond
	  ((eq arg 4) org-clock-default-task)
	  ((and (org-clock-is-active)
		(equal org-clock-default-task (cadr org-clock-history)))
	   (caddr org-clock-history))
	  ((org-clock-is-active) (cadr org-clock-history))
	  ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
	  (t (car org-clock-history)))))
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))


(setq org-agenda-log-mode-items (quote (clock)))
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t)))

(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

;; global Effort estimate values
;; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 5:00 8:00 10:00 12:00")
				    ("STYLE_ALL" . "habit"))))

(require 'org-checklist)

(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/git/org/diary.org")
(setq org-agenda-insert-diary-extract-time t)

(org-babel-do-load-languages
 'org-babel-load-languages '((python . t) (R . t)))


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

