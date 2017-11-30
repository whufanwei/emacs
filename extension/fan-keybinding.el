;; file operate

(global-set-key (kbd "C-x c") 'prelude-copy-file-name-to-clipboard)
(global-set-key (kbd "C-c k") 'prelude-kill-other-buffers)
(global-set-key (kbd "M-p") 'ace-window)

(global-set-key (kbd "C-h a") 'apropos)

;; Transpose stuff with M-t

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-c r") 'anzu-query-replace-regexp)

(global-set-key (kbd "M-=") 'count-words);

(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "C-c n") 'fancy-narrow-to-region);
(global-set-key (kbd "C-c w") 'fancy-widen);
(global-set-key (kbd "C-c s") 'fan-swap-meta-and-super)
(global-set-key (kbd "C-c j") 'just-one-space)
(global-set-key (kbd "C-c \\") 'align-regexp)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-c f") 'fill-individual-paragraphs)
(global-set-key (kbd "C-c l") 'goto-last-change)
(global-set-key (kbd "C-c y") 'browse-kill-ring)


(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)



(provide 'fan-keybinding)
