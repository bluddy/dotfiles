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
(setq evil-want-C-u-scroll t)
		  
(evil-define-motion evil-ace-jump-word-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 1)))

(evil-define-motion evil-ace-jump-char-to-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)
   (forward-char -1)))

; Add fuzzy completion with C-P
(define-key evil-normal-state-map (kbd "C-P") 'fiplr-find-file)

(add-hook 'ace-jump-mode-end-hook 'exit-recursive-edit)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
;;(define-key evil-motion-state-map (kbd "C-SPC") 'ace-jump-word-mode)


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

; Merlin
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(setq opam-bin (substring (shell-command-to-string "opam config var bin 2> /dev/null") 0 -1))
(setq merlin-command (concat opam-bin "/ocamlmerlin"))
(add-hook 'tuareg-mode-hook 'merlin-mode)
(require 'merlin)

; Merlin auto-completion
(setq merlin-use-auto-complete-mode t)

; Evil-jumper: jump like in vim
(require 'evil-jumper)

; Evil-surround
(require 'evil-surround)
(global-evil-surround-mode 1)

; Evil-tabs
(global-evil-tabs-mode t)

(require 'evil-visualstar)

(require 'evil-indent-textobject)

(require 'evil-numbers)

; Remove toolbar
(tool-bar-mode -1)

; Cool color themes
(require 'color-theme)
(color-theme-initialize)

; Add _ as a word character
(add-hook 'tuareg-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
