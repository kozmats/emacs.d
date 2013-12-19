;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-theme 'solarized-dark t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; frame setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (boundp 'window-system)
	(setq default-frame-alist
	  (append
	   (list
		'(vertical-scroll-bars . nil) ;;スクロールバーはいらない
		'(alpha . (95 95)))		  ;;透明度
	   default-frame-alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; whitespace-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
;; see whitespace.el for more details
;;(setq whitespace-style '(face tabs tab-mark spaces space-mark newline-mark))
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
	  '((space-mark ?\u3000 [?\u25a1])
		(newline-mark ?\n [?\u21B5 ?\n] [?$ ?\n])
		(tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-newline "#002b36")
(set-face-background 'whitespace-newline "#003846")
(set-face-foreground 'whitespace-tab "#002b36")
(set-face-background 'whitespace-tab "#003846")
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#002b36")
(set-face-background 'whitespace-space "#003846")
(set-face-bold-p     'whitespace-space t)
;;(global-whitespace-mode 1)
;;(global-set-key (kbd "C-x w") 'global-whitespace-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight cursor line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface hlline-face
  '((((class color)
	  (background dark))
	 (:background "#003846"))
	(((class color)
	  (background light))
	 (:background "#003846"))
	(t
	 ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fullscreen (For hackers-only patch emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((eq window-system 'mac)
  (defun my-toggle-fullscreen ()
	"Toggle fullscreen."
	(interactive)
	(if (eq (frame-parameter nil 'fullscreen) 'fullboth)
		(progn
		  (set-frame-parameter nil 'fullscreen nil)
		  (display-time-mode 0))
	  (set-frame-parameter nil 'fullscreen 'fullboth)
	  (display-time-mode 1)))

  (global-set-key "\C-cf" 'my-toggle-fullscreen)
  (set-frame-parameter nil 'sticky t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font environment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((eq window-system 'mac)
  (create-fontset-from-ascii-font "Ricty Discord-12:weight=normal:slant=normal" nil "myfavoritefontset")
  (set-fontset-font "fontset-myfavoritefontset"
		    'japanese-jisx0208
		    (font-spec :family "Ricty Discord" :size 12)
		    nil
		    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-myfavoritefontset"))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)
	  (".*Ricty.*" . 1.0)
	  (".*Inconsolata.*" . 1.0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EOF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mark-eob ()
  (let ((existing-overlays (overlays-in (point-max) (point-max)))
	(eob-mark (make-overlay (point-max) (point-max) nil t t))
	(eob-text "[EOF]"))
	;; 急EOFマークを削除
	(dolist (next-overlay existing-overlays)
	  (if (overlay-get next-overlay 'eob-overlay)
	  (delete-overlay next-overlay)))
	;; 新規EOF マークの表示
	(put-text-property 0 (length eob-text)
			   'face '(foreground-color . "#003846") eob-text)
	(overlay-put eob-mark 'eob-overlay t)
	(overlay-put eob-mark 'after-string eob-text)))
(add-hook 'find-file-hooks 'my-mark-eob)
