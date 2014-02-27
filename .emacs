(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

; Set the color theme
(cond ((> emacs-major-version 23)
       (load-theme 'tango-dark))
      (t (add-to-list 'load-path (expand-file-name "~/.emacs.d/color-theme-6.6.0/"))
	    (require 'color-theme)
	    (eval-after-load "color-theme"
	      '(progn
		 (color-theme-initialize)
		 (color-theme-ron)))))

; Tweak default scroll behavior
(scroll-bar-mode -1)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)

; Leave search highlighting on, like vim does
(setq lazy-highlight-cleanup nil)

; Make page-[up|down] scroll only 1/2 page at a time

(defvar *scroll-height* (/ (window-height (selected-window)) 2))

(global-set-key [(control ?v)]
		(lambda () (interactive (scroll-up *scroll-height*))))

(global-set-key [(meta ?v)]
		(lambda () (interactive (scroll-down *scroll-height*))))

;; (defun scroll-down-in-place (n)
;;   (interactive "p")
;;   (previous-line n)
;;   (unless (eq (window-start) (point-min))
;;     (scroll-down n)))

;; (defun scroll-up-in-place (n)
;;   (interactive "p")
;;   (next-line n)
;;   (unless (eq (window-end) (point-max))
;;     (scroll-up n)))

;; (global-set-key "\M-n" 'scroll-up-in-place)
;; (global-set-key "\M-p" 'scroll-down-in-place)
;; (global-set-key [(control ?v)]
;; 		(lambda () (interactive (scroll-up-in-place *scroll-height*))))
;; (global-set-key [(meta ?v)]
;; 		(lambda () (interactive (scroll-down-in-place *scroll-height*))))

; No toolbars!
(tool-bar-mode -1)
(menu-bar-mode -1)

; Paren mode
(show-paren-mode 1)
(setq show-paren-mode-delay 0)

; Leave search highlighting on like vim does.
(setq lazy-highlight-cleanup nil)

; imitate vim's sweet sweet ctrl-y command
(autoload 'copy-from-above-command "misc"
    "Copy characters from previous nonblank line, starting just above point.
##
  \(fn &optional arg)"
    'interactive)

(global-set-key [up] 'copy-from-above-command)

(global-set-key [down] (lambda ()
                        (interactive)
                        (forward-line 1)
                        (open-line 1)
                        (copy-from-above-command)))

(global-set-key [right] (lambda ()
                         (interactive)
                         (copy-from-above-command 1)))

(global-set-key [left] (lambda ()
                        (interactive)
                        (copy-from-above-command -1)
                        (forward-char -1)
                        (delete-char -1)))

; Show buffer list in current window
(global-set-key "\C-x\C-b" 'buffer-menu)

; sweet-ass interactive-do mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; Make mit-scheme the default
(setq scheme-program-name "/usr/local/bin/mit-scheme")
(require 'xscheme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sml/client ((t (:inherit default))))
 '(sml/filename ((t (:inherit sml/global :foreground "brightcyan" :weight bold))))
 '(sml/folder ((t (:foreground "brightcyan")))))

; Setup scala-mode
;(add-to-list 'load-path (expand-file-name "~/scala-dist/tool-support/src/emacs"))
;(require 'scala-mode-auto)

; centered cursor mode
;; (and
;;  (require 'centered-cursor-mode)
;;  (global-centered-cursor-mode +1))

; From https://sites.google.com/site/steveyegge2/effective-emacs

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(defalias 'qrr 'query-replace-regexp)

; end

; Setup smart-mode-line
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

; SLIME mode
(setq inferior-lisp-program scheme-program-name)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime-2013-04-05"))

; Suggested by mit-scheme-swank
(when (require 'slime nil t)

  (defun mit-scheme-start-swank (file encoding)
    (format "%S\n\n" `(start-swank ,file)))

  (defun mit-scheme-find-buffer-package ()
    (save-excursion
      (let ((case-fold-search t))
        (goto-char (point-min))
        (and (re-search-forward "^;+ package: \\(([^)]+)\\)" nil t)
             (match-string-no-properties 1)))))

  (defun mit-scheme-slime-mode-init ()
    (slime-mode t)
    (make-local-variable 'slime-find-buffer-package-function)
    (setq slime-find-buffer-package-function 'mit-scheme-find-buffer-package))

  ; fix some debugger issues - mjt
  ;(slime-setup) ; <- original code
  (slime-setup '(slime-fancy slime-asdf)) ; <- Found suggested in Stack Overflow post
  ; end fix - mjt
  (if (not (memq 'mit-scheme slime-lisp-implementations))
      (setq slime-lisp-implementations
          (cons '(mit-scheme ("mit-scheme")
            :init mit-scheme-start-swank)
            slime-lisp-implementations)))
  (setq slime-default-lisp 'mit-scheme)
  (add-hook 'scheme-mode-hook 'mit-scheme-slime-mode-init))

;; Setup git-gutter
;(cond ((> emacs-major-version 22)
;       (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-git-gutter"))
;       (require 'git-gutter)
;       (global-git-gutter-mode +1)))

; Coffeescript mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/coffee-mode"))
(require 'coffee-mode)

; Perl mode
(defalias 'perl-mode 'cperl-mode)

; Rainbow delimiters
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rainbow-delimiters"))
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
