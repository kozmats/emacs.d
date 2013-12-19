;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(set-language-environment 'Japanese)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exec-path config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'exec-path "~/.rbenv/shims/")
(add-to-list 'exec-path "~/.ndenv/shims/")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/bin")

;; (defun set-exec-path-from-shell-PATH ()
;;   "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
;;   This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;;
;; (set-exec-path-from-shell-PATH)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mac environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq window-system 'mac)
    (progn
      (set-default-coding-systems 'utf-8)
      (setq default-buffer-file-coding-systems 'utf-8)
      (setq coding-locale-system 'utf-8)

      ;;ターミナルUTF-8対応
      (prefer-coding-system 'utf-8-unix)
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (set-buffer-file-coding-system 'utf-8)

      ;; ファイル名の文字コード
      (require 'ucs-normalize)
      (set-file-name-coding-system 'utf-8-hfs-mac)
      (setq locale-coding-system 'utf-8-hfs-mac)

      ;; 修飾キーの扱い
      (setq mac-command-modifier 'meta)
      (setq mac-control-modifier 'control)
      (setq mac-option-modifier 'meta)

      ;; システムへ修飾キーを渡さない設定
      (setq mac-pass-control-to-system nil)
      (setq mac-pass-command-to-system nil)
      (setq mac-pass-option-to-system nil)

      ;; reload chrome
      (defun reload-chrome ()
        (interactive)
        (shell-command "osascript ~/.emacs.d/reload-chrome.scpt"))

      ;; move next tab chrome
      (defun next-tab-chrome ()
        (interactive)
        (shell-command "osascript ~/.emacs.d/next-tab-chrome.scpt")
        (message "next-tab-chrome"))

      ;; move previous tab chrome
      (defun previous-tab-chrome ()
        (interactive)
        (shell-command "osascript ~/.emacs.d/previous-tab-chrome.scpt")
        (message "previous-tab-chrome"))

      (global-set-key (kbd "C-c C-c r") 'reload-chrome)
      (global-set-key (kbd "C-c C-c n") 'next-tab-chrome)
      (global-set-key (kbd "C-c C-c p") 'previous-tab-chrome)

      ;; drag-drop
      (define-key global-map [ns-drag-file] 'ns-find-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacsclient
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;;クライアントを終了するとき終了するかどうかを聞かない
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 終了時のフレームサイズを記憶する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when window-system
  (defun my-window-size-save ()
     (let* ((rlist (frame-parameters (selected-frame)))
                (ilist initial-frame-alist)
                (nCHeight (frame-height))
                (nCWidth (frame-width))
                (tMargin (if (integerp (cdr (assoc 'top rlist)))
                                             (cdr (assoc 'top rlist)) 0))
                (lMargin (if (integerp (cdr (assoc 'left rlist)))
                                             (cdr (assoc 'left rlist)) 0))
                buf
                (file "~/.framesize.el"))
       (if (get-file-buffer (expand-file-name file))
               (setq buf (get-file-buffer (expand-file-name file)))
             (setq buf (find-file-noselect file)))
       (set-buffer buf)
       (erase-buffer)
       (insert (concat
                        ;; 初期値をいじるよりも modify-frame-parameters
                        ;; で変えるだけの方がいい?
                        "(delete 'width initial-frame-alist)\n"
                        "(delete 'height initial-frame-alist)\n"
                        "(delete 'top initial-frame-alist)\n"
                        "(delete 'left initial-frame-alist)\n"
                        "(setq initial-frame-alist (append (list\n"
                        "'(width . " (int-to-string nCWidth) ")\n"
                        "'(height . " (int-to-string nCHeight) ")\n"
                        "'(top . " (int-to-string tMargin) ")\n"
                        "'(left . " (int-to-string lMargin) "))\n"
                        "initial-frame-alist))\n"
                        ;;"(setq default-frame-alist initial-frame-alist)"
                        ))
       (save-buffer)
       ))

  (defun my-window-size-load ()
     (let* ((file "~/.framesize.el"))
       (if (file-exists-p file)
               (load file))))

  (my-window-size-load)

  ;; Call the function above at C-x C-c.
  (defadvice save-buffers-kill-emacs
     (before save-frame-size activate)
     (my-window-size-save))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; リージョンをBackspaceで削除
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
;;UTF-8 Dired文字化け対応
(add-hook 'dired-before-readin-hook
          (lambda ()
            (set (make-local-variable 'coding-system-for-read) 'utf-8)))
;; コメント内のカッコは無視
(setq parse-sexp-ignore-comments t)
;; 対応する括弧を表示
(show-paren-mode t)
;; ツールバー消去
(tool-bar-mode nil)
;; タイトル変更
(setq frame-title-format "%b (%f)")
;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
;;リージョンに色を付ける
(setq transent-mark-mode t)
;; Quartz 2D のアンチエイリアスを利用
;;(setq mac-allow-anti-aliasing t)
;; ファイル指定時に新しいウインドウを開かない設定
(setq ns-pop-up-frames nil)
;; バッテリー残量表示
(display-battery-mode 1)
;; モードラインに時刻表示
(setq dayname-j-alist
      '(("Sun" . "日") ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
        ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")))
(setq display-time-string-forms
      '((format " %s年%s月%s日(%s) %s:%s"
                year month day
                (cdr (assoc dayname dayname-j-alist))
                24-hours minutes)))
(display-time)
;; タイトル変更
(setq frame-title-format "%b (%f)")
;;折り返さない
(setq truncate-lines t)
(setq truncate-partial-width-windows t)
;; シェルスクリプトを保存する際に自動的にchmod +xを行う
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
;; file が他から変更されたら、自動的に読み込む。
(global-auto-revert-mode t)
;; not create *.~ files
(setq make-backup-files nil)
;; not create .#* files
(setq auto-save-default nil)
;; (yes/no) を (y/n)に
(fset 'yes-or-no-p 'y-or-n-p)
;; OSのクリップボードを使う
(setq x-select-enable-clipboard t)
;; ビープ音を消す
(setq ring-bell-function (lambda ()))
;; よそのウインドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)
;; 画像ファイルを表示
(auto-image-file-mode)
;; ls
(setq dired-use-ls-dired nil)
(setq list-directory-brief-switches "-C")
;; ediff でハイライトできる最大サイズを調整
(setq-default ediff-auto-refine-limit 10000)
;; 保存する前に不用な空白を削除してしまう
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; 最後に改行を入れる。
(setq require-final-newline t)
;; scratch buffer の初期メッセージを消す
(setq initial-scratch-message "")
;; cua-mode
(setq cua-enable-cua-keys nil)
(cua-mode t)
