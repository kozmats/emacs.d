;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'auto-complete-config nil t)
  (global-auto-complete-mode nil)
  (ac-config-default)
  (setq ac-auto-start t)
  (setq ac-dwim t)
  (setq ac-ignore-case 'smart)                                                  ;; 補完対象に大文字が含まれる場合のみ区別する
  (setq ac-use-menu-map t)                                                      ;; C-n/C-pで候補選択可能
  ;;(add-to-list 'ac-sources 'ac-source-yasnippet)                              ;; 常にYASnippetを補完候補に
  ;;install-packages で入れた場合勝手に設定するので消しておく
  (setq ac-quick-help-prefer-x t)                                               ;; pos-tip.el のレンダリングを使用する
  ;; RHTML
  (setq ac-modes
        (append ac-modes '(rhtml-mode)))
  ;; JavaScript
  (setq ac-modes
        (append ac-modes '(js2-mode)))
  ;; CoffeeScript
  (setq ac-modes
        (append ac-modes '(coffee-mode)))
  )

(define-key ac-mode-map (kbd "C-i") 'auto-complete)

(require 'ac-dabbrev)
(setq ac-sources (list ac-source-dabbrev ))

(setq ac-skk-alist-file "~/ac-skk-alist.el")
(setq ac-skk-jisyo-file "~/skkdic/SKK-JISYO.L")

(require 'ac-ja)
(setq ac-sources (append ac-sources '(ac-source-dabbrev-ja)))

(eval-after-load "skk"
  '(progn
     (defadvice skk-kakutei (after ad-skk-kakutei last)
       "skk-kakuteiの後にatuo-complete-modeによる補完を実行するadvice"
       (unless (minibufferp)
         (ac-start)))))

(add-hook 'skk-mode-hook
          (lambda ()
            "skk-kakuteiのadviceを活性化"
            (interactive)
            (ad-activate 'skk-kakutei)))

(defadvice skk-mode-exit (before ad-skk-mode-exit last)
  "skk-modeから抜ける時にskk-kakuteiのadviceを不活性化。"
  (ad-deactivate 'skk-kakutei))

(require 'ac-helm)  ;; Not necessary if using ELPA package
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)
