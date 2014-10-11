;;; fan-latex.el
;;
;; Copyright (c) 2012 欧阳威
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; Version: 0.1
;; Keywords: funtion

(add-to-list 'load-path "~/emacs/auctex-11.87" t)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;(setq preview-scale-function 1.5)
(setq LaTeX-math-mode t)

(require 'cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode

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
                             (setq TeX-electric-escape t)      ;; 按 \ 后光标跳
                             (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
                             (setq TeX-view-program-list '(("PDF Viewer" "open %o")))
                             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode) -shell-escape%' %t" TeX-run-TeX nil t))
                             (setq TeX-command-default "XeLaTeX")
                             ;;定义latex-mode下的快捷键
                             (define-key LaTeX-mode-map (kbd "C-c C-p") 'reftex-parse-all)
                             (setq LaTeX-section-hook
                                   '(LaTeX-section-heading
                                     LaTeX-section-title
                                     LaTeX-section-section
                                     LaTeX-section-label))))
(provide 'fan-latex)
