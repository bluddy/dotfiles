(require 'package)

;; MELPA is the most up-to-date archive
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; get list of packages if not present
(unless package-archive-contents
  (package-refresh-contents))
 
;; make sure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Make use-package available
(require 'use-package)

; Remove toolbar
(if window-system
    (tool-bar-mode -1))
    
; Rebind alt-h for help
(global-set-key "\M-h" help-map)

(setq-default indent-tabs-mode nil) ; No tabs allowed
(show-paren-mode 1) ; Show matching parens like vim
(setq show-paren-delay 0)

(use-package evil
  :ensure evil
  :config
  (progn
    ;;Make evil-mode up/down operate in screen lines instead of logical lines
    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

    ;;Exit insert mode by pressing j and then k quickly
    (setq key-chord-two-keys-delay 0.2)
    (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
    (key-chord-mode 1)

    (use-package fiplr
      :ensure fiplr
      :config
      ; Add fuzzy completion with C-P
      (define-key evil-normal-state-map (kbd "C-P") 'fiplr-find-file))

    ;;; esc quits
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
    
    ;; Dired activator
    (evil-define-command evil-dired()
      "Activate dired at the current directory"
      (dired ""))
    ;; Dired: activate with '-'
    (define-key evil-normal-state-map (kbd "-") 'evil-dired)

    ;; Add ex commands to allow mistyping
    (evil-ex-define-cmd "E[dit]" 'evil-edit)
    (evil-ex-define-cmd "W[rite]" 'evil-write)
    (evil-ex-define-cmd "Wq" 'evil-save-and-close)
    (evil-ex-define-cmd "WQ" 'evil-save-and-close)
    (evil-ex-define-cmd "Wq" 'evil-save-and-close)
    (evil-ex-define-cmd "Qa[ll]" "quitall")
    (evil-ex-define-cmd "qA[ll]" "quitall")
    (evil-ex-define-cmd "QA[ll]" "quitall")
    
    (use-package evil-leader
      :ensure evil-leader
      :config
      (progn
        (setq evil-leader/in-all-states 1)
        (global-evil-leader-mode)
        (evil-leader/set-leader "<SPC>")))

    (use-package ace-jump-mode
      :ensure ace-jump-mode
      :config
      (evil-leader/set-key "<SPC>" 'ace-jump-mode))

    (evil-mode 1)

    (use-package evil-jumper
      ; Evil-jumper: jump like in vim
      :ensure evil-jumper)
    (use-package evil-surround
      :ensure evil-surround
      :config
      (global-evil-surround-mode 1))
    (use-package evil-tabs
      :ensure evil-tabs
      :config
      (global-evil-tabs-mode t))
    (use-package evil-visualstar
      :ensure evil-visualstar)
    (use-package evil-indent-textobject
      :ensure evil-indent-textobject)
    (use-package evil-numbers
      :ensure evil-numbers)

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
  )
)

(use-package auto-complete
  :ensure auto-complete)

;; merlin
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(setq opam-bin (substring (shell-command-to-string "opam config var bin 2> /dev/null") 0 -1))
(setq merlin-command (concat opam-bin "/ocamlmerlin"))

(use-package merlin
  :config
  (progn
    (add-hook 'tuareg-mode-hook 'merlin-mode)
    ; Merlin auto-completion
    (setq merlin-use-auto-complete-mode t))
)

(use-package ag
  :ensure ag)
 
(use-package relative-line-numbers
  :ensure relative-line-numbers
  :config
  (global-relative-line-numbers-mode t))
  
(use-package powerline
  :ensure powerline
  :config
  (use-package powerline-evil
    :ensure powerline-evil
    :config
    (powerline-evil-vim-color-theme)
  )
)

(use-package flycheck
  :ensure flycheck
  :config
  (progn
    (setq flycheck-check-syntax-automatically '(save-mode-enabled))
    (global-flycheck-mode t)

    ; flycheck errors on tooltip
    (if window-system
      (custom-set-variables '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
  )
)

(use-package projectile
  :ensure projectile)

(use-package helm
  :ensure helm
  :config
  (progn
    (use-package helm-projectile
      :ensure helm-projectile)
    (setq helm-quick-update t)
    (setq helm-bookmark-show-location t)
    (setq helm-buffers-fuzzy-matching t)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (define-key helm-map (kbd "C-j") 'helm-next-line)
    (define-key helm-map (kbd "C-k") 'helm-previous-line)

    ; Custom combination of buffer sources
    (defun helm-my-buffers ()
      (interactive)
      (let
        ((sources 
          (append
            (if (projectile-project-buffer-p (current-buffer) ".")
              '(helm-source-projectile-files-list)
              ())
            '(helm-source-buffers-list
               helm-source-elscreen
               helm-source-ctags
               helm-source-recentf
               helm-source-locate))))
        (helm-other-buffer sources "*helm-my-buffers*")))

    (evil-leader/set-key "uu" 'helm-my-buffers)
  )
)

; Cool color themes
(require 'color-theme)
(color-theme-initialize)

; Add _ as a word character
(add-hook 'tuareg-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Add .emacs to auto-mode-alist for emacs
(setq auto-mode-alist
  (append '((".*\\.emacs\\'" . lisp-mode))
          auto-mode-alist))
