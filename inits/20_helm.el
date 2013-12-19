;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'helm)
(require 'helm-config)
(require 'helm-command)
(require 'helm-imenu)
(require 'helm-files)
(require 'helm-ag)
(helm-mode 1)

(defun my-helm ()
  (interactive)
  (helm :sources '(helm-c-source-buffers-list
                   helm-c-source-mac-spotlight
                   helm-c-source-recentf
                   helm-c-source-files-in-current-dir
                   )
        :buffer "*helm custom*"))

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x i") 'helm-imenu)
(global-set-key (kbd "C-;")   'my-helm)
(global-set-key (kbd "M-r")   'helm-resume)
(global-set-key (kbd "M-y")   'helm-show-kill-ring)
(global-set-key (kbd "M-x")   'helm-M-x)
(global-set-key (kbd "C-c ;") 'my-helm)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "C-M-s") 'helm-ag-this-file)
(global-set-key (kbd "C-l")   'helm-dabbrev)

;; helm-ag
(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
(setq helm-ag-insert-at-point 'symbol)

;; emacsの終了時に、履歴を保存する
(remove-hook 'kill-emacs-hook 'helm-c-adaptive-save-history)

;; ディレイは0.2秒
(setq helm-input-idle-delay 0.02)

;; 候補のディレクトリが一つしかない場合に、自動的に展開しない
(setq helm-ff-auto-update-initial-value nil)

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))

;; C-hでバックスペースと同じように文字を削除
(define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char)

;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; helm でパス表示
(setq helm-ff-transformer-show-only-basename nil)
