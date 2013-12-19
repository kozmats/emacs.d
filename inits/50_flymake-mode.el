;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(load-library "flymake-cursor")

;; flymake (Emacs22から標準添付されている)
(when (require 'flymake nil t)
  (global-set-key "\C-cp" 'flymake-goto-prev-error)
  (global-set-key "\C-cn" 'flymake-goto-next-error)

  ;; GUIの警告は表示しない
  ;; (setq flymake-gui-warnings-enabled nil)

  ;; (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  ;;	(setq flymake-check-was-interrupted t))
  ;; (ad-activate 'flymake-post-syntax-check)

  ;; 全てのファイルで flymakeを有効化
  ;;(add-hook 'find-file-hook 'flymake-find-file-hook)

  ;; colors
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "dark slate blue")

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; PHP用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-php-init))
  ;;   (defun flymake-php-init ()
  ;;     (let* ((temp-file	  (flymake-init-create-temp-buffer-copy
  ;;       			   'flymake-create-temp-inplace))
  ;;            (local-file  (file-relative-name
  ;;       		   temp-file
  ;;       		   (file-name-directory buffer-file-name))))
  ;;       (list "php" (list "-f" local-file "-l"))))
  ;;   (setq flymake-allowed-file-name-masks
  ;;         (append
  ;;          flymake-allowed-file-name-masks
  ;;          '(("\\.php[345]?$" flymake-php-init))))
  ;;   (setq flymake-err-line-patterns
  ;;         (cons
  ;;          '("\\(?:Parse\\|Fatal\\|syntax\\) error[:,] \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil 1)
  ;;          flymake-err-line-patterns)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; JavaScript用設定 (js2-modeでやる)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-javascript-init))
  ;;   ;; flymake-javascript-initが未定義のバージョンだったら、自分で定義する
  ;;   (defun flymake-javascript-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;; 			 'flymake-create-temp-inplace))
  ;; 	     (local-file (file-relative-name
  ;; 			  temp-file
  ;; 			  (file-name-directory buffer-file-name))))
  ;; 	(list "jsl" (list "-process" local-file))
  ;; 	))
  ;;   (setq flymake-allowed-file-name-masks
  ;; 	  (append
  ;; 	   flymake-allowed-file-name-masks
  ;; 	   '(("\\.json$" flymake-javascript-init)
  ;; 	     ("\\.js$" flymake-javascript-init))))
  ;;   (setq flymake-err-line-patterns
  ;; 	  (cons
  ;; 	   '("\\(.+\\)(\\([0-9]+\\)): \\(?:lint \\)?\\(\\(?:warning\\|SyntaxError\\):.+\\)" 1 2 nil 3)
  ;; 	   flymake-err-line-patterns)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; HTML用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-html-init))
  ;;   (defun flymake-html-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       		 'flymake-create-temp-inplace))
  ;;            (local-file (file-relative-name
  ;;       		  temp-file
  ;;       		  (file-name-directory buffer-file-name))))
  ;;       ;;(list "tidy" (list local-file))))
  ;;       (list "tidyp" (list "-utf8" local-file)))) ;; 日本語エラー対策
  ;;
  ;;   (add-to-list 'flymake-allowed-file-name-masks
  ;;       	 '("\\.html$\\|\\.ctp" flymake-html-init))
  ;;
  ;;   (add-to-list 'flymake-err-line-patterns
  ;;       	 '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
  ;;       	   nil 1 2 4)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Haskell用設定
  ;; http://d.hatena.ne.jp/jeneshicc/20090630/1246364354
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-Haskell-init))
  ;;   (defun flymake-Haskell-init ()
  ;;     (flymake-simple-make-init-impl
  ;;      'flymake-create-temp-with-folder-structure nil nil
  ;;      (file-name-nondirectory buffer-file-name)
  ;;      'flymake-get-Haskell-cmdline))
  ;;   (defun flymake-get-Haskell-cmdline (source base-dir)
  ;;     (list "ghc"
  ;; 	    (list "--make" "-fbyte-code"
  ;; 		  (concat "-i"base-dir)
  ;; 		  source)))
  ;;   (defvar multiline-flymake-mode nil)
  ;;   (defvar flymake-split-output-multiline nil)
  ;;   (defadvice flymake-split-output
  ;;     (around flymake-split-output-multiline activate protect)
  ;;     (if multiline-flymake-mode
  ;; 	  (let ((flymake-split-output-multiline t))
  ;; 	    ad-do-it)
  ;; 	ad-do-it))
  ;;   (defadvice flymake-split-string
  ;;     (before flymake-split-string-multiline activate)
  ;;     (when flymake-split-output-multiline
  ;; 	(ad-set-arg 1 "^\\s *$")))
  ;;   (add-hook
  ;;    'haskell-mode-hook
  ;;    '(lambda ()
  ;; 	(add-to-list 'flymake-allowed-file-name-masks
  ;; 		     '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
  ;; 	(add-to-list 'flymake-err-line-patterns
  ;; 		     '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
  ;; 		       1 2 3 4))
  ;; 	(set (make-local-variable 'multiline-flymake-mode) t)
  ;; 	(if (not (null buffer-file-name)) (flymake-mode))
  ;; 	)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Ruby 用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-ruby-init))
  ;;   (defun flymake-ruby-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       		 'flymake-create-temp-inplace))
  ;;            (local-file (file-relative-name
  ;;       		  temp-file
  ;;       		  (file-name-directory buffer-file-name))))
  ;;       (list "~/.rbenv/shims/ruby" (list "-c" local-file))))
  ;;   (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  ;;   (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
  ;;   (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; coffee-script 用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-coffeelint-init))
  ;;   (defun flymake-coffeelint-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       		 'flymake-create-temp-inplace))
  ;;            (local-file (file-relative-name
  ;;       		  temp-file
  ;;       		  (file-name-directory buffer-file-name))))
  ;;       (list "coffeelint" (list "--csv" local-file))))
  ;;   (add-to-list 'flymake-err-line-patterns
  ;;                '(".+,\\(.+\\),\\(.+\\),\\(.+\\)"
  ;;                  nil 1 nil 3))
  ;;   (add-to-list 'flymake-allowed-file-name-masks
  ;;       	 '("\\.coffee\\'" flymake-coffeelint-init)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; haml 用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-haml-init))
  ;;   (defun flymake-haml-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       		 'flymake-create-temp-inplace))
  ;;            (local-file (file-relative-name
  ;;       		  temp-file
  ;;       		  (file-name-directory buffer-file-name))))
  ;;       (list "~/.rbenv/shims/haml" (list "-c" local-file))))
  ;;   (add-to-list 'flymake-err-line-patterns
  ;;                '("^Syntax error on line \\([0-9]+\\): \\(.*\\)$"
  ;;                  nil 1 nil 2))
  ;;   (add-to-list 'flymake-allowed-file-name-masks
  ;;       	 '("\\.haml\\'" flymake-haml-init)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; css 用設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (when (not (fboundp 'flymake-css-init))
  ;;   (defun flymake-css-init ()
  ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       		 'flymake-create-temp-inplace))
  ;;            (local-file (file-relative-name
  ;;       		  temp-file
  ;;       		  (file-name-directory buffer-file-name))))
  ;;       (list "~/.ndenv/shims/csslint" (list "--format=compact" local-file))))
  ;;   (add-to-list 'flymake-err-line-patterns
  ;;                '("^\\(.*\\): line \\([[:digit:]]+\\), col \\([[:digit:]]+\\), \\(.+\\)$"
  ;;                  1 2 3 4))
  ;;   (add-to-list 'flymake-allowed-file-name-masks
  ;;       	 '("\\.css\\'" flymake-css-init)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; hook 設定
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add-hook 'html-mode-hook
	    '(lambda ()
               (flymake-haml-load)
               (flymake-mode t)))
  (add-hook 'php-mode-hook
	    '(lambda ()
               (flymake-php-load)
               (flymake-mode t)))
  (add-hook 'ruby-mode-hook
	    (lambda ()
              (flymake-ruby-load)
              (flymake-mode t)))
  (add-hook 'haml-mode-hook
  	    (lambda ()
              (flymake-haml-load)
              (flymake-mode t)))
  (add-hook 'css-mode-hook
  	    (lambda ()
              (flymake-css-init)
              (flymake-mode t)))
  (add-hook 'sass-mode-hook
  	    (lambda ()
              (flymake-sass-load)
              (flymake-mode t)))
  (add-hook 'yaml-mode-hook
  	    (lambda ()
              (flymake-yaml-load)
              (flymake-mode t)))
  (add-hook 'json-mode-hook
  	    (lambda ()
              (flymake-json-load)
              (flymake-mode t)))
  (add-hook 'coffee-mode-hook
	    (lambda ()
              (flymake-coffee-load)
              (flymake-mode t)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake の警告を pop で
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'pos-tip)
(require 'auto-complete)
(defun my-popup-flymake-display-error ()
  (interactive)
  (let* ((line-no			 (flymake-current-line-no))
	 (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info
							   line-no)))
	 (count				 (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
	(let* ((file	   (flymake-ler-file (nth (1- count)
						  line-err-info-list)))
	       (full-file (flymake-ler-full-file (nth (1- count)
						      line-err-info-list)))
	       (text	  (flymake-ler-text (nth (1- count)
						 line-err-info-list)))
	       (line	  (flymake-ler-line (nth (1- count)
						 line-err-info-list))))
	  (popup-tip (format "[line:%s] %s" line text))))
      (setq count (1- count)))))

(global-set-key "\C-ce" 'my-popup-flymake-display-error)
