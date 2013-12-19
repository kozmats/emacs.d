;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; skk-setup
(require 'skk-setup)

;; skk-study
(require 'skk-study)

;; context-skk
(require 'context-skk)
(add-to-list 'context-skk-programming-mode 'php-mode)
(add-to-list 'context-skk-programming-mode 'lisp-mode)
(add-to-list 'context-skk-programming-mode 'java-mode)
(add-to-list 'context-skk-programming-mode 'ruby-mode)
(add-to-list 'context-skk-programming-mode 'c++-mode)

;; skk-server
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")

;; 候補表示
(setq skk-show-inline t)
;; (setq skk-show-tooltip t)
;; (setq skk-show-candidates-always-pop-to-buffer t)
(setq skk-henkan-show-candidates-rows 2) ; 候補表示件数を2列に
;; 動的候補表示
(setq skk-dcomp-activate t)			 ; 動的補完
(setq skk-dcomp-multiple-activate t)	 ; 動的補完の複数候補表示
(setq skk-dcomp-multiple-rows 10)	 	 ; 動的補完の候補表示件数
;; 動的補完の複数表示群のフェイス
(set-face-foreground 'skk-dcomp-multiple-face "Black")
(set-face-background 'skk-dcomp-multiple-face "LightGoldenrodYellow")
(set-face-bold-p 'skk-dcomp-multiple-face nil)
;; 動的補完の複数表示郡の補完部分のフェイス
(set-face-foreground 'skk-dcomp-multiple-trailing-face "dim gray")
(set-face-bold-p 'skk-dcomp-multiple-trailing-face nil)
;; 動的補完の複数表示郡の選択対象のフェイス
(set-face-foreground 'skk-dcomp-multiple-selected-face "White")
(set-face-background 'skk-dcomp-multiple-selected-face "LightGoldenrod4")
(set-face-bold-p 'skk-dcomp-multiple-selected-face nil)
;; 英語補完
(setq skk-use-look t)

;; 漢字登録時、送り仮名が厳密に正しいかをチェック
(setq skk-check-okurigana-on-touroku t)
;; ローマ字 prefix をみて補完する
(setq skk-comp-use-prefix t)
;; 補完時にサイクルする
(setq skk-comp-circulate t)
;; 個人辞書の文字コードを指定する
(setq skk-jisyo-code 'utf-8)

;; 言語
;; (setq skk-japanese-message-and-error t) ; エラーを日本語に
;; (setq skk-show-japanese-menu t)	; メニューを日本語に

;; 注釈の表示
(setq skk-show-annotation t)
;; インジケータを左端に.
(setq skk-status-indicator 'left)
;; skk モードの表示のカスタマイズ
;; (setq skk-latin-mode-string "[aa]")
;; (setq skk-hiragana-mode-string "[jj]")
;; (setq skk-katakana-mode-string "[qq]")
;; (setq skk-jisx0208-latin-mode-string "[AA]")
;; (setq skk-jisx0201-mode-string "[QQ]")
;; (setq skk-indicator-use-cursor-color nil)
;; (setq skk-show-inline 'vertical)
;; (when skk-show-inline
;;   (if (boundp 'skk-inline-show-face)
;;       (setq
;;        skk-inline-show-background-color "black")))
;; カーソルには色をつけない
;;(setq skk-use-color-cursor nil)

;; キーバインド
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-mode)
(global-set-key "\C-j" 'skk-mode)
(global-set-key "\C-\\" 'skk-mode)

;; 半角カナを入力
(setq skk-use-jisx0201-input-method t)
;; Enter で改行しない
(setq skk-egg-like-newline t)
;;"「"を入力したら"」"も自動で挿入
(setq skk-auto-insert-paren t)
;; ;; 句読点変換ルール
;; (setq skk-kuten-touten-alist
;;   '(
;;     (jp . ("." . "," ))
;;     (en . ("." . ","))
;;     ))
;; jp でも ".""," を使う. ←最近不評でどうしたモンかしらん.
;; (setq skk-kutouten-type 'en)
;; 全角記号の変換
(setq skk-rom-kana-rule-list
      (append skk-rom-kana-rule-list
              '(("!" nil "!")
                (":" nil ":")
                (";" nil ";")
                ("?" nil "?")
                ("z " nil "　")
                ("\\" nil "\\")
                )))
;; 全角英語モードで U+FF0D, U+FF5E を入力する?
;; (when (not (string< mule-version "6.0"))
;;   (aset skk-jisx0208-latin-vector ?- (string #xFF0D))
;;   (aset skk-jisx0208-latin-vector ?~ (string #xFF5E)))
;; @で挿入する日付表示を西暦&半角に
(setq skk-date-ad t)
(setq skk-number-style nil)
;; 送り仮名が厳密に正しい候補を優先
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書の共有
(setq skk-share-private-jisyo t)

;; ddskk 起動時のみ, インクリメンタルサーチを使用
;;; Isearch setting.
(add-hook 'isearch-mode-hook
          #'(lambda ()
              (when (and (boundp 'skk-mode)
                         skk-mode
                         skk-isearch-mode-enable)
                (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          #'(lambda ()
              (when (and (featurep 'skk-isearch)
                         skk-isearch-mode-enable)
                (skk-isearch-mode-cleanup))))
;; migemo を使うので skk-isearch にはおとなしくしていて欲しい
(setq skk-isearch-start-mode 'latin)
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
(add-hook 'isearch-mode-hook 'skk-isearch-mode-cleanup)

;; AquaSKKの辞書をつかうようにする
(if (eq window-system 'mac)
    (progn
      (setq skk-large-jisyo (expand-file-name "~/Library/Application Support/AquaSKK/SKK-JISYO.L"))
      (setq mac-pass-control-to-system nil)))
