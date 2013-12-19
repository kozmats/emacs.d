;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; w3m
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; w3mのbinaryの場所指定
(setq w3m-command "/usr/local/bin/w3m")
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)
(autoload 'w3m-namazu "w3m-namazu" "Search files with Namazu." t)
;; デフォルトで使う検索エンジン
(setq w3m-search-default-engine "google")
;; 天気のデフォルト場所
(setq w3m-weather-default-area "東京都・東京")
;; 画面右端3文字で折り返し
(setq w3m-fill-column -3)
;; ホーム
(setq w3m-home-page "http://www.google.co.jp/")
;; icons
(setq w3m-icon-directory "~/.emacs.d/elisp/emacs-w3m/icon")
;; cookie
(setq w3m-use-cookies t)
;; form
(setq w3m-use-form t)
;; tab
(setq w3m-use-tab t)
;; Inline画像表示
;; (setq w3m-display-inline-image t)
;; (setq w3m-default-display-inline-images t)
(put 'narrow-to-region 'disabled nil)
;; favicon 使う
(setq w3m-use-favicon t)
(setq w3m-favicon-use-cache-file t)
;; favicon のキャッシュ有効期限(3600sec)
(setq w3m-favicon-cache-expire-wait 3600)

;; ;;---- keybind ------
;; ;; タブを閉じる
;; (define-key w3m-mode-map (kbd "C-c C-k") 'w3m-delete-buffer)
;; ;; タブ切り替え
;; (define-key w3m-mode-map (kbd "C-c C-n") 'w3m-tab-next-buffer)
;; (define-key w3m-mode-map (kbd "C-c C-p") 'w3m-tab-previous-buffer)
;; ;; リンクを新しいタブで開く
;; (define-key w3m-mode-map (kbd "C-c C-l") 'w3m-view-this-url-new-session)
;; ;; Bookmarkを閲覧
;; (define-key w3m-mode-map (kbd "C-c C-b") 'helm-w3m-bookmarks)
;; ;; Emacs-w3m を browse-url のデフォールト・ブラウザーにする
;; (setq browse-url-browser-function 'w3m-browse-url)
;; ;; 新規タブで browse-url する
;; (setq browse-url-new-window-flag t)
