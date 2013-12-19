;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ack を grep で利用
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-x grep-find で Perl の ack コマンドを使うよう変更
(setq grep-find-command "/usr/local/bin/ag --nocolor --nogroup ")

;; M-x grep-by-ag
;; Perl の ack コマンドを使ったgrep(カーソル付近の単語をデフォルトの検索語に)
(defun grep-by-ag ()
  "grep the whole directory for something defaults to term at cursor position"
  (interactive)
  (setq default-word (thing-at-point 'symbol))
  (setq needle1 (or (read-string (concat "ag for <" default-word ">: ")) default-word))
  (setq needle1 (if (equal needle1 "") default-word needle1))
  (setq default-dir default-directory)
  (setq needle2 (or (read-string (concat "target directory <" default-dir ">: ")) default-dir))
  (setq needle2 (if (equal needle2 "") default-dir needle2))
  (grep-find (concat "/usr/local/bin/ag --nocolor --nogroup " needle1 " " needle2)))

(global-set-key (kbd "C-x g") 'grep-by-ag)
