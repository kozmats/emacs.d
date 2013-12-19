;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mic-paren
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(paren-activate)
; 下線
;(setq paren-match-face '(underline paren-face))
; bold
;; (setq paren-match-face 'bold paren-sexp-mode t)
;; (setq paren-sexp-mode t)
(setq show-paren-style 'mixed)
(setq paren-match-face 'bold paren-sexp-mode t)
(setq paren-sexp-mode t)
(set-face-background 'show-paren-match-face "CadetBlue")
(set-face-foreground 'show-paren-match-face "red")
