;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; twittering-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'twittering-mode "twittering-mode" nil t)
(eval-after-load "twittering-mode"
  '(progn
     (setq twittering-auth-method 'xauth)
     (setq twittering-username "_koji_matsu_")  ; your twitter id

     ;; URL 短縮
     (setq twittering-tinyurl-service 'bit.ly)
     (setq twittering-bitly-login "kozmats")
     (setq twittering-bitly-api-key "R_dfdc4d296cb8905946cd1e57d724eeef")

     ;; 実行キー追加 デフォルトは[f4]キー
     (global-set-key (kbd "C-c C-u") 'twittering-tinyurl-replace-at-point)

     (add-hook 'twittering-mode-hook
               (lambda ()
                 (setq twittering-timer-interval 60)                                                          ;; 60秒で自動更新
                 (setq twittering-display-remaining t)                                                        ;; mode-line に API の残数を表示する
                 (set-face-bold-p 'twittering-username-face t)
                 (setq twittering-icon-mode t)                                                                ;; アイコンを表示する
                 (setq twittering-convert-fix-size 25)                                                        ;; アイコンサイズを変更する *48以外を希望する場合 要 imagemagickコマンド
                 (setq twittering-edit-skelton 'inherit-mensions)                                             ;; Reply all
                 (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
                 (set-face-foreground 'twittering-uri-face "gray60")
                 (setq twittering-status-format "%i %p%s (%S),  %@:\n%FILL[  ]{%T // from %f%L%r%R}")
                 (setq twittering-retweet-format " RT @%s: %t")
                 (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)             ;; "N"で発言
                 (define-key twittering-mode-map (kbd "D") 'twittering-direct-message)                        ;; "D"でDM
                 (define-key twittering-mode-map (kbd "F") 'twittering-favorite)                              ;; "F"でお気に入り
                 (define-key twittering-mode-map (kbd "R") 'twittering-retweet)                               ;; "R"でリツイートできるようにする
                 (define-key twittering-mode-map (kbd "T") 'twittering-native-retweet)                        ;; "T"で公式リツイートできるようにする
                 (define-key twittering-mode-map (kbd "<") (lambda () (interactive) (goto-char (point-min)))) ;; "<"">"で先頭、最後尾にいけるように
                 (define-key twittering-mode-map (kbd ">") (lambda () (interactive) (goto-char (point-max))))))
     ))
