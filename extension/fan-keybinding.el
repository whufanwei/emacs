;; file operate

(global-set-key (kbd "C-x c") 'prelude-copy-file-name-to-clipboard)
(global-set-key (kbd "C-c k") 'prelude-kill-other-buffers)
(global-unset-key (kbd "C-x f")) ;; which used to be transpose-words
(global-set-key (kbd "C-x f") 'ido-recentf-open)
(global-set-key (kbd "C-x C-r") 'prelude-rename-file-and-buffer)
(global-set-key (kbd "C-x j") 'ace-jump-buffer)
(global-set-key (kbd "M-p") 'ace-window)


(key-chord-define-global "jj" 'switch-to-previous-buffer)
(key-chord-define-global "ss" 'prelude-swap-meta-and-super)
(key-chord-define-global "aa" 'projectile-ack)


(global-set-key (kbd "C-h a") 'apropos)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t c") 'transpose-chars)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(global-set-key (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-c r") 'anzu-query-replace-regexp)

(global-set-key (kbd "M-=") 'count-words);
(global-set-key (kbd "M-w") 'easy-kill)
(global-set-key (kbd "M-/") 'ac-complete-words-in-all-buffer)
(global-set-key (kbd "M-k") 'sp-splice-sexp);

(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "C-c n") 'fancy-narrow-to-region);
(global-set-key (kbd "C-c w") 'fancy-widen);
(global-set-key (kbd "C-c s") 'prelude-swap-meta-and-super)
(global-set-key (kbd "C-c j") 'just-one-space)
(global-set-key (kbd "C-c \\") 'align-regexp)
(global-set-key (kbd "C-c e") 'eval-buffer)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-c f") 'fill-individual-paragraphs)
(global-set-key (kbd "C-c l") 'goto-last-change)


(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;; (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
;; (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
;; (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)


;;;;;;;;
;;   S-=   

(provide 'fan-keybinding)
