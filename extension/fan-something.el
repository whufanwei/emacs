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

(use-package rainbow-delimiters
  :ensure t)

(use-package lisp-mode
  :diminish eldoc-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode))

(use-package fix-word
  :bind
  (("M-u" . fix-word-upcase)
   ("M-l" . fix-word-downcase)
   ("M-c" . fix-word-capitalize)))

(defun single-lines-only ()
  "replace multiple blank lines with a single one"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\\(^\\s-*$\\)\n" nil t)
    (replace-match "\n")
    (forward-char 1)))

(defun xah-convert-fullwidth-chars (@begin @end &optional @to-direction)
  "Convert ASCII chars to/from Unicode fullwidth version.
Works on current line or text selection.

The conversion direction is determined like this: if the command
has been repeated, then toggle. Else, always do to-Unicode
direction.

If `universal-argument' is called first:

 no C-u → Automatic.
 C-u → to ASCII
 C-u 1 → to ASCII
 C-u 2 → to Unicode


Version 2018-08-02"

  (interactive
   (let ($p1 $p2)
     (if (use-region-p)
         (progn
           (setq $p1 (region-beginning))
           (setq $p2 (region-end)))
       (progn
         (setq $p1 (line-beginning-position))
         (setq $p2 (line-end-position))))
     (list $p1 $p2
           (cond
            ((equal current-prefix-arg nil) "auto")
            ((equal current-prefix-arg '(4)) "ascii")
            ((equal current-prefix-arg 1) "ascii")
            ((equal current-prefix-arg 2) "unicode")
            (t "unicode")))))
  (let* (
         ($ascii-unicode-map
          [
           ["0" "０"] ["1" "１"] ["2" "２"] ["3" "３"] ["4" "４"] ["5" "５"] ["6" "６"] ["7" "７"] ["8" "８"] ["9" "９"]
           ["A" "Ａ"] ["B" "Ｂ"] ["C" "Ｃ"] ["D" "Ｄ"] ["E" "Ｅ"] ["F" "Ｆ"] ["G" "Ｇ"] ["H" "Ｈ"] ["I" "Ｉ"] ["J" "Ｊ"] ["K" "Ｋ"] ["L" "Ｌ"] ["M" "Ｍ"] ["N" "Ｎ"] ["O" "Ｏ"] ["P" "Ｐ"] ["Q" "Ｑ"] ["R" "Ｒ"] ["S" "Ｓ"] ["T" "Ｔ"] ["U" "Ｕ"] ["V" "Ｖ"] ["W" "Ｗ"] ["X" "Ｘ"] ["Y" "Ｙ"] ["Z" "Ｚ"]
           ["a" "ａ"] ["b" "ｂ"] ["c" "ｃ"] ["d" "ｄ"] ["e" "ｅ"] ["f" "ｆ"] ["g" "ｇ"] ["h" "ｈ"] ["i" "ｉ"] ["j" "ｊ"] ["k" "ｋ"] ["l" "ｌ"] ["m" "ｍ"] ["n" "ｎ"] ["o" "ｏ"] ["p" "ｐ"] ["q" "ｑ"] ["r" "ｒ"] ["s" "ｓ"] ["t" "ｔ"] ["u" "ｕ"] ["v" "ｖ"] ["w" "ｗ"] ["x" "ｘ"] ["y" "ｙ"] ["z" "ｚ"]
           ["," "，"] ["." "．"] [":" "："] [";" "；"] ["!" "！"] ["?" "？"] ["\"" "＂"] ["'" "＇"] ["`" "｀"] ["^" "＾"] ["~" "～"] ["¯" "￣"] ["_" "＿"]
           [" " "　"]
           ["&" "＆"] ["@" "＠"] ["#" "＃"] ["%" "％"] ["+" "＋"] ["-" "－"] ["*" "＊"] ["=" "＝"] ["<" "＜"] [">" "＞"] ["(" "（"] [")" "）"] ["[" "［"] ["]" "］"] ["{" "｛"] ["}" "｝"] ["(" "｟"] [")" "｠"] ["|" "｜"] ["¦" "￤"] ["/" "／"] ["\\" "＼"] ["¬" "￢"] ["$" "＄"] ["£" "￡"] ["¢" "￠"] ["₩" "￦"] ["¥" "￥"]
           ]
          )
         ($reverse-map
          (mapcar
           (lambda (x) (vector (elt x 1) (elt x 0)))
           $ascii-unicode-map))

         ($stateBefore
          (if (get 'xah-convert-fullwidth-chars 'state)
              (get 'xah-convert-fullwidth-chars 'state)
            (progn
              (put 'xah-convert-fullwidth-chars 'state 0)
              0
              )))
         ($stateAfter (if (eq $stateBefore 0) 1 0 )))


    (let ((case-fold-search nil))
      (xah-replace-pairs-region
       @begin @end
       (cond
        ((string= @to-direction "unicode") $ascii-unicode-map)
        ((string= @to-direction "ascii") $reverse-map)
        ((string= @to-direction "auto")
         (if (eq $stateBefore 0)
             $reverse-map
           $ascii-unicode-map ))
        (t (user-error "Your 3rd argument 「%s」 isn't valid" @to-direction)))
       t t ))
    (put 'xah-convert-fullwidth-chars 'state $stateAfter)))

(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))

(provide 'fan-something)
