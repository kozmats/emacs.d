;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Gnu global
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm-gtags
(require 'helm-config)
(require 'helm-gtags)

(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only nil)
(setq helm-gtags-auto-update nil)

;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c .") 'helm-gtags-next-history)
             (local-set-key (kbd "C-c ,") 'helm-gtags-previous-history)
             (local-set-key (kbd "M-t")   'helm-gtags-find-tag)
             (local-set-key (kbd "M-r")   'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s")   'helm-gtags-find-symbol)
             (local-set-key (kbd "C-t")   'helm-gtags-pop-stack)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'undohist)
(undohist-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-mode-lighter " UT")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linum-mode
;;;;;;;;;;;;;;;;;;;;s;;;;;;;;;;;;;;;;;;;;;;;;
(require 'linum)
(require 'linum-off)

(global-set-key "\C-xl" 'linum-mode)
;;(global-linum-mode t)

;; linum-mode がクソ重い問題対策
;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 関数折り畳む設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-library "hideshow")

;; hs-toggle-function
(defvar my-hs-state-hide nil)
(defun hs-toggle-function()
  "toggle all functions for php or c"
  (interactive)
  (if my-hs-state-hide
      (progn (hs-show-all) (setq my-hs-state-hide nil))
    (hs-hide-function))
  )
(defun hs-hide-function()
  (interactive)
  (setq my-hs-state-hide t)
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "function.*?(.*?)" nil t)
      (if (search-forward "{" nil t )
          (hs-hide-block)))))

(define-key hs-minor-mode-map (kbd "C-c C-c C-f") 'hs-toggle-function)
(define-key hs-minor-mode-map (kbd "C-c C-f") 'hs-toggle-hiding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode-common-hook
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c-mode-common-hook
          '(lambda ()
             (hs-minor-mode 1)
             (linum-on)
             ;; (whitespace-turn-on)
             (helm-gtags-mode 1)
             (setq c-basic-offset 4
                   tab-width 4
                   c-basic-offset 4
                   indent-tabs-mode t)
             (c-set-style "stroustrup")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-lisp-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (linum-on)
             (when (require 'auto-complete nil t)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-dabbrev-ja
                                          ac-source-filename))
               (auto-complete-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; php-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; php-mode-hook は c-mode-common-hook を継承してる
(add-hook 'php-mode-hook
          '(lambda ()
             (c-set-style "stroustrup")
             (setq c-basic-offset 4
                   indent-tabs-mode t
                   tab-width 4)
             (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                                     64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
             ;; コメントのスタイル
             (setq comment-start "// "
                   comment-end   ""
                   comment-start-skip "// *")
             ;; emacs-php-align
             ;; https://github.com/tetsujin/emacs-php-align
             (when (require 'php-align nil t)
               (php-align-setup))
             (define-key php-mode-map (kbd "C-c C-a") 'align-current)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-dabbrev-ja
                                          ac-source-php-extras
                                          ac-source-php-completion-patial
                                          ac-source-filename))
               (auto-complete-mode t))))

;; 拡張子が *.tplと*.incはphp-modeにする
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\)\\'" 'js2-mode))

(add-hook 'js2-mode-hook
          '(lambda()
             ;; gtags-mode
             (helm-gtags-mode 1)
             (linum-on)
             (setq js2-cleanup-whitespace nil
                   js2-minor-mode t
                   js2-cleanup-whitespace nil)
             ;; keybind
             (define-key js2-mode-map (kbd "C-c C-f") 'js2-mode-toggle-element)
             (define-key js2-mode-map (kbd "C-m") nil)
             ;; indent setting
             (when (require 'espresso nil t)
               (setq indent-tabs-mode t
                     c-basic-offset 4
                     tab-width 4
                     espresso-indent-level 4
                     espresso-expr-indent-offset 4))
             (when (require 'ac-company nil t)
               (ac-company-define-source ac-source-company-dabbrev company-dabbrev))
             ;; auto-complete setting
             (when (require 'auto-complete nil t)
               (setq ac-js2-evaluate-calls t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-company-dabbrev
                                          ac-source-dabbrev-ja
                                          ;; ac-source-gtags
                                          ac-source-filename))
               (add-to-list 'ac-dictionary-files "~/.emacs.d/ac-dict-file") ;; 辞書へのパス
               (auto-complete-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rinari & ruby-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-hook 'rhtml-mode-hook
          '(lambda () 
             (linum-on)
             (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; gtags-mode
             (helm-gtags-mode 1)
             (linum-on)
             (rinari-launch)
             ;; (whitespace-turn-on)
             ;; indent setting
             (setq ruby-indent-level 2
                   ruby-indent-tabs-mode nil)
             ;; electric pair (> emacs24)
             (electric-pair-mode t)
             (electric-indent-mode t)
             (electric-layout-mode t)
             (define-key ruby-mode-map (kbd "C-c C-a") 'align-current)
             ;; ruby-end
             (ruby-end-mode t)
             ;; ruby-block
             (ruby-block-mode t)
             (setq ruby-block-highlight-toggle t)
             ;; auto-complete setting
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-company-dabbrev
                                          ac-source-dabbrev-ja
                                          ac-source-gtags
                                          ac-source-filename))
               (auto-complete-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; coffee-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

(add-hook 'coffee-mode-hook
          '(lambda()
             (setq indent-tabs-mode nil
                   tab-width 2
                   coffee-tab-width 2)
             (linum-on)
             ;; auto-complete setting
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-dabbrev
                                          ac-source-dabbrev-ja
                                          ac-source-filename))
               (auto-complete-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; haml-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))

(add-hook 'haml-mode-hook
          '(lambda()
             (setq indent-tabs-mode nil
                   tab-width 2)
             (linum-on)
             ;; auto-complete setting
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-dabbrev
                                          ac-source-dabbrev-ja
                                          ac-source-filename))
               (auto-complete-mode t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-hook 'web-mode-hook
          '(lambda()
             ;; comment style
             ;;   1:htmlのコメントスタイル(default)
             ;;   2:テンプレートエンジンのコメントスタイル
             ;;      (Ex. {# django comment #},{* smarty comment *},{{-- blade comment --}})
             (setq web-mode-comment-style 2
                   web-mode-script-padding 0
                   web-mode-style-padding 0
                   web-mode-block-padding 0)
             (setq web-mode-disable-css-colorization t
                   web-mode-enable-block-face t
                   web-mode-enable-comment-keywords t
                   web-mode-enable-current-element-highlight t
                   web-mode-enable-heredoc-fontification t)
             ;; indent-setting
             (setq indent-tabs-mode t
                   tab-width 4
                   web-mode-markup-indent-offset 4 ;; html indent
                   web-mode-css-indent-offset 4    ;; css indent
                   web-mode-code-indent-offset 4)  ;; script indent(js,php,etc...)
             ;;keybind
             (define-key web-mode-map (kbd "C-;") 'my-helm)
             (when (require 'ac-company nil t)
               (ac-company-define-source ac-source-company-css company-css)
               (ac-company-define-source ac-source-company-dabbrev company-dabbrev))
             ;; auto-complete setting
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources '(ac-source-words-in-all-buffer
                                          ac-source-company-dabbrev
                                          ac-source-company-css
                                          ac-source-dabbrev-ja
                                          ac-source-filename))
               (auto-complete-mode t))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Align settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'align)

;; for php-mode
;; http://d.hatena.ne.jp/Tetsujin/20070614/
(add-to-list 'align-rules-list
             '(php-assignment
               (regexp . "[^-=!^&*+<>/.| \t\n]\\(\\s-*[.-=!^&*+<>/|]*\\)=>?\\(\\s-*\\)\\([^= \t\n]\\|$\\)")
               (justify .t)
               (tab-stop . nil)
               (modes . '(php-mode))))
(add-to-list 'align-dq-string-modes 'php-mode)
(add-to-list 'align-sq-string-modes 'php-mode)
(add-to-list 'align-open-comment-modes 'php-mode)
(setq align-region-separate (concat "\\(^\\s-*$\\)\\|"
                                    "\\([({}\\(/\*\\)]$\\)\\|"
                                    "\\(^\\s-*[)}\\(\*/\\)][,;]?$\\)\\|"
                                    "\\(^\\s-*\\(}\\|for\\|while\\|if\\|else\\|"
                                    "switch\\|case\\|break\\|continue\\|do\\)[ ;]\\)"
                                    ))
;; for ruby-mode
;; http://d.hatena.ne.jp/rubikitch/20080227/1204051280
(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes  . '(ruy-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-assignment-literal
               (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list                  ;TODO add to rcodetools.el
             '(ruby-xmpfilter-mark
               (regexp . "\\(\\s-*\\)# => [^#\t\n]")
               (repeat . nil)
               (modes  . '(ruby-mode))))

