;; Font settings, tool-bar, scroll-bar and menu if off.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil :family "Ubuntu" :height 100)


;; Package system repo.
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)


;; Linum.
(require 'linum)
(global-linum-mode)


;; Replacing yes/no to y/n.
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)


;; Auto-complete.
(require 'auto-complete)
(global-auto-complete-mode t)


;; Kill prevous word with C-w and goto-line.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-g" 'goto-line)


;; Replacing query-replace-regexp to "qrr".
(defalias 'qrr 'query-replace-regexp)


;; Emacs jabber.
(require 'jabber-autoloads)
(custom-set-variables
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268BD2" "#d33682" "#00877C" "#002b36"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (clues)))

 '(jabber-account-list (quote (("*nick*" (:password . "*password") (:network-server . "*server*") (:connection-type . ssl)))))
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)))))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#222222")
 '(vc-annotate-color-map (quote ((20 . "#fa5151") (40 . "#e43838") (60 . "#f8ffa0") (80 . "#e8e815") (100 . "#fe8b04") (120 . "#e5c900") (140 . "#32cd32") (160 . "#8ce096") (180 . "#7fb07f") (200 . "#3cb370") (220 . "#099709") (240 . "#2fdbde") (260 . "#1fb3b3") (280 . "#8cf1f1") (300 . "#94bff3") (320 . "#62b6ea") (340 . "#00aff5") (360 . "#e353b9"))))
 '(vc-annotate-very-old-color "#e353b9"))

(setq
 jabber-history-enabled t
 jabber-use-global-history nil
 jabber-backlog-number 40
 jabber-backlog-days 30
 )

(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" " notify"
  		 libnotify-program "--expire-time=3000" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                             (jabber-jid-displayname (jabber-jid-user from)))
                     (format "%s: %s" (jabber-jid-resource from) text)))
    (notify-send (format "%s" (jabber-jid-displayname from))
                 text)))

(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)


;; Sessions.
(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)


;; Powerline.
(require 'powerline)
(powerline-default-theme)


;; Smex - auto-complete commands.
(require 'smex)
(global-set-key "\C-x\C-m" 'smex)
(global-set-key "\C-c\C-m" 'smex)


;; Autopair.
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers


;; MPD-client.
(add-to-list 'load-path "~/.emacs.d/mingus/")
(require 'mingus)


;; ido.
(require 'ido)
(ido-mode t)
(autoload 'idomenu "idomenu" nil t)


;; Org-mode.
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(setq org-log-done 'time)
(setq org-log-done 'note)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (list "~/.org/org/default.org"
			     "~/.org/org/edu.org"
			     "~/.org/org/anime.org"
			     "~/.org/org/home.org"))


;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;; Syntax highlighting everywhere.
(global-font-lock-mode 1)


;; FIXME-BUG-TODO
(require 'fic-ext-mode)
(fic-ext-mode)


;; ECB custom.
(require 'ecb)
'(ecb-auto-activate t)
'(ecb-layout-name "leftright1")
'(ecb-layout-window-sizes (quote (("leftright1" (ecb-directories-buffer-name 0.171875 . 0.39215686274509803) (ecb-sources-buffer-name 0.171875 . 0.27450980392156865) (ecb-history-buffer-name 0.171875 . 0.3137254901960784) (ecb-methods-buffer-name 0.140625 . 0.9803921568627451)))))
'(ecb-options-version "2.40")
'(ecb-source-path (quote (("/" "/"))))
'(ede-project-directories (quote ("/home/sena" "/home/deb-user")))
(custom-set-faces
 '(ecb-analyse-face ((t (:inherit ecb-default-highlight-face :background "black"))))
 '(ecb-default-highlight-face ((((class color) (min-colors 89)) (:background "#268bd2" :foreground "#fdf6e3"))))
 '(ecb-directory-face ((t (:inherit ecb-default-highlight-face :background "black")))))


;; Parentheses.
(require 'highlight-parentheses)


;; Python.
(require 'python)
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.py$" . pretty-lambda-mode) auto-mode-alist))


;; Smart-tab.
(require 'smart-tab)
(global-smart-tab-mode 1)


;; Dimming buffers.
(auto-dim-other-buffers-mode)


;; Transpose buffers hotkey.
(defun transpose-buffers (arg)
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
(global-set-key "\C-x4" 'transpose-buffers)


;; Go to the last change
(require 'goto-chg)
(global-set-key "\C-q" 'goto-last-change)


;; Sticky control.
(require 'control-lock)
(global-set-key "\C-z" 'control-lock-toggle)


;; Google translate.
(require 'google-translate)
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ru")
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)

;; Getting things done.
(defun gtd ()
   (interactive)
   (find-file "~/.org/org/gtd.org") )
(defun gtd-save ()
  (interactive)
  (setq file-name (format "GTD-%s.org"
                          (format-time-string "%Y-%m-%d")))
  (write-file file-name))

(defun gtd-save ()
  (interactive)
  (setq file-name (format "GTD-%s.org"
                          (format-time-string "%Y-%m-%d")))
  (write-file file-name))


;; Idents.
(setq-default tab-width 4)
(put 'downcase-region 'disabled nil)


;; c++.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(defun my-c++-mode-hook ()
  (c-set-style "linux"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(custom-set-faces
 '(ecb-default-highlight-face ((t (:background "dim gray")))))
