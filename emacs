(require 'package)

; Remove toolbar
(if window-system (tool-bar-mode -1))

(setq-default indent-tabs-mode nil) ; No tabs allowed
(show-paren-mode 1) ; Show matching parens like vim
(setq show-paren-delay 0)

;; MELPA is the most up-to-date archive
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'evil)

;;Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;Exit insert mode by pressing j and then k quickly
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

; Add fuzzy completion with C-P
(define-key evil-normal-state-map (kbd "C-P") 'fiplr-find-file)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Add ex commands to allow mistyping
(evil-ex-define-cmd "E[dit]" 'evil-edit)
(evil-ex-define-cmd "W[rite]" 'evil-write)
(evil-ex-define-cmd "Wq" 'evil-save-and-close)
(evil-ex-define-cmd "WQ" 'evil-save-and-close)
(evil-ex-define-cmd "Wq" 'evil-save-and-close)
(evil-ex-define-cmd "Qa[ll]" "quitall")
(evil-ex-define-cmd "qA[ll]" "quitall")
(evil-ex-define-cmd "QA[ll]" "quitall")

(evil-mode 1)

; Merlin
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(setq opam-bin (substring (shell-command-to-string "opam config var bin 2> /dev/null") 0 -1))
(setq merlin-command (concat opam-bin "/ocamlmerlin"))
(require 'merlin)
(add-hook 'tuareg-mode-hook 'merlin-mode)

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

; Cool color themes
(require 'color-theme)
(color-theme-initialize)

; Add _ as a word character
(add-hook 'tuareg-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))

; Add ag to use silver searcher
(require 'ag)

; Tmux support -------

(defun tmux-command (direction)
  (shell-command-to-string
    (concat "tmux select-pane -"
      (tmux-direction direction))))

(defun tmux-direction (direction)
  (upcase
    (substring direction 0 1)))

(evil-define-command evil-tmux-window-left (count)
  "Move the cursor to new COUNT-th window left of the current one, or to a tmux window."
  :repeat nil
  (interactive "p")
  (dotimes (i count)
    (condition-case nil
      (windmove-left)
      (error (tmux-command "L")))))

(evil-define-command evil-tmux-window-right (count)
  "Move the cursor to new COUNT-th window right of the current one, or to a tmux window."
  :repeat nil
  (interactive "p")
  (dotimes (i count)
    (condition-case nil
      (windmove-right)
      (error (tmux-command "R")))))

(evil-define-command evil-tmux-window-down (count)
  "Move the cursor to new COUNT-th window down of the current one, or to a tmux window."
  :repeat nil
  (interactive "p")
  (dotimes (i count)
    (condition-case nil
      (windmove-down)
      (error (tmux-command "D")))))

(evil-define-command evil-tmux-window-up (count)
  "Move the cursor to new COUNT-th window up of the current one, or to a tmux window."
  :repeat nil
  (interactive "p")
  (dotimes (i count)
    (condition-case nil
      (windmove-up)
      (error (tmux-command "U")))))

; Make ctrl-hjkl move around windows
(if window-system
  (progn
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right))
  (define-key evil-normal-state-map (kbd "C-h") 'evil-tmux-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-tmux-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-tmux-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-tmux-window-right))

