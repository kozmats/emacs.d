;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)

;; comple-log
(push '("*Comple-Log*" :height 30) popwin:special-display-config)

;; dired
(push '(dired-mode :position top :height 40) popwin:special-display-config)
;; php-manual
(push '(" *php-manual*" :height 50) popwin:special-display-config)

(require 'dired-x)
(global-set-key "\C-xd" 'dired-jump-other-window)

;; helm
(push '("^\*helm .+\*$" :regexp t :position bottom :height 0.3) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t :position bottom :height 0.3) popwin:special-display-config)
(push '("*helm*" :height 0.3 :position bottom) popwin:special-display-config)
;;(push '("*helm kill ring*" :height 0.3 :position bottom) popwin:special-display-config)

;; undo-tree
;;(push '(" *undo-tree*" :height 0.3 :position bottom) popwin:special-display-config)

;; buffer list
(push '("*Buffer List*" :height 0.3 :position bottom) popwin:special-display-config)

;; show last popwin
(define-key global-map (kbd "M-p") 'popwin:display-last-buffer)

