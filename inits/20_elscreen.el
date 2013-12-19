;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elscreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'elscreen)
(elscreen-start)

(setq elscreen-prefix-key "\C-z")
(if window-system
	(define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; 以下は自動でスクリーンを生成する場合の設定
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
	   ,ad-do-it
	 (elscreen-create)
	 (elscreen-notify-screen-modification 'force-immediately)
	 (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(setq elscreen-display-tab 20) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示

;; (global-set-key (kbd "C-z C-c") 'elscreen-clone) ; 今のウインドウを基に作成
;; (global-set-key (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers) ; スクリーンとバッファをkill
(global-set-key [(C-tab)] 'elscreen-next) ; ブラウザみたいに
(global-set-key [(C-S-tab)] 'elscreen-previous) ; ブラウザみたいに その2

;; change tab color
(set-face-background 'elscreen-tab-current-screen-face "#335D6E")
(set-face-foreground 'elscreen-tab-current-screen-face "gray60")
