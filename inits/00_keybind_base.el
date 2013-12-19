;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key binding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\M-?" 'help)				; M-?をHelp
(global-set-key "\C-u" 'undo)				; Undo
(global-set-key "\C-h" 'delete-backward-char)		; C-hをBackSpace
(global-set-key "\C-\\" 'toggle-input-method)		; C-\で日本語入力
(global-set-key "\C-w" 'kill-region)			; Cut
(global-set-key "\M-w" 'copy-region-as-kill)		; Copy
(global-set-key "\C-y" 'yank)				; Paste
(global-set-key "\C-cg" 'goto-line)			; 指定行へジャンプ
(global-set-key "\C-xp" 'previous-multiframe-window)	; 前のバッファへ移動
(global-set-key "\C-xn" 'next-multiframe-window)	; 次のバッファへ移動
(global-set-key "\C-j" 'ignore)			        ; C-jを無効化させる
(global-set-key [backspace] 'delete-backward-char)	; タブはタブとして消す
(global-set-key [S-right] 'enlarge-window-horizontally) ; バッファを水平方向に拡大
(global-set-key [S-left] 'shrink-window-horizontally)	; バッファを水平方向に縮小
(global-set-key [S-down] 'enlarge-window)		; バッファを垂直方向に拡大
(global-set-key [S-up] 'shrink-window)			; バッファを垂直方向に縮小
(global-set-key [M-kanji] 'ignore)			; Alt-Kanjiキーでベルがうっさいので無効化
(global-set-key [?\C-,] 'backward-list)	                ; 対応する括弧に移動(C-M-f/p相当)
(global-set-key [?\C-.] 'forward-list)			; 対応する括弧に移動(C-M-f/p相当)

(global-unset-key "\C-z")				; C-zを無効化
(global-unset-key [C-return])				; helm が握っている c-return を無効化

(global-set-key (kbd "C-c C-c m") 'git-messenger:popup-message) ;; git のログメッセージを表示する

;; http://d.hatena.ne.jp/kitokitoki/20100131/p4
;; C-aで「行頭」と「インデントを飛ばした行頭」を行き来する
(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)    
      (beginning-of-line)))

(global-set-key "\C-a" 'my-move-beginning-of-line)
