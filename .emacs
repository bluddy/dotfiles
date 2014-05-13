(require 'package)

;; MELPA is the most up-to-date archive
(add-to-list 'package-archives
	                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
;;			 '("marmalade" . "http://marmalade-repo.org/packages/") ;;t)
(package-initialize)
(require 'evil)

;;Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;Exit insert mode by pressing j and then k quickly
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

;;Not sure why this isn’t the default – it is in vim – but this makes C-u to go up half a page
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
		  
(evil-define-motion evil-ace-jump-word-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 1)))

(evil-define-motion evil-ace-jump-char-to-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)
   (forward-char -1)))

(add-hook 'ace-jump-mode-end-hook 'exit-recursive-edit)

;; some proposals for binding:

(define-key evil-motion-state-map (kbd "SPC") 'ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "C-SPC") 'ace-jump-word-mode)

(define-key evil-operator-state-map (kbd "SPC") 'ace-jump-char-mode) ; similar to f
(define-key evil-operator-state-map (kbd "C-SPC") 'ace-jump-char-to-mode) ; similar to t
(define-key evil-operator-state-map (kbd "M-SPC") 'ace-jump-word-mode)

;;Personally I like ace-jump to be limited to the window I’m working in
(setq ace-jump-mode-scope 'window)

;
;
;(defadvice evil-visual-block (before spc-for-char-jump activate)
;  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode))

;; -- end of acejump code


;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; Make ctrl-hjkl move around windows
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(evil-mode 1)
